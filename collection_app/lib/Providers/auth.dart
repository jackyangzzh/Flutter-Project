import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/HttpException.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expirationDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String get getToken {
    if (_expirationDate != null &&
        _expirationDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get getUserId {
    return _userId;
  }

  Future<void> _authenticate(String url, String email, String password) async {
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expirationDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
      final pref = await SharedPreferences.getInstance();
      final _userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expireDate': _expirationDate.toIso8601String()
      });
      pref.setString('userData', _userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB-fLa7XnEd3oQ1LclJdS1KIpc6njhmXf8';

    return _authenticate(url, email, password);
  }

  Future<void> login(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB-fLa7XnEd3oQ1LclJdS1KIpc6njhmXf8';

    return _authenticate(url, email, password);
  }

  Future<bool> tryLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }
    final _userData =
        json.decode(pref.getString('userData')) as Map<String, Object>;
    final expireDate = DateTime.parse(_userData['expireDate']);

    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = _userData['token'];
    _userId = _userData['userId'];
    _expirationDate = expireDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  void logout() {
    _userId = null;
    _token = null;
    _expirationDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timer = _expirationDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timer), logout);
  }
}
