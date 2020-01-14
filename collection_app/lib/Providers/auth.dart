import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/HttpException.dart';

class Auth with ChangeNotifier {
  String _token;
  String _expirationDate;
  String _userId;

  Future<void> _authenticate(String url, String email, String password) async {
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body)['error'];
      if (responseData != null) {
        throw HttpException(responseData['error']['message']);
      }
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
}
