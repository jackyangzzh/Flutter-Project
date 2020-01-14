import '../Models/HttpException.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum Mood {
  Miserable,
  Disappointing,
  Average,
  Happy,
  Amazing,
}

class Collection with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  bool isFavoriate;

  Collection(
      {@required this.id,
      @required this.title,
      @required this.description,
      this.location,
      @required this.imageUrl,
      this.isFavoriate = false});

  Future<void> selectFavoriate() async {
    final oldStatus = isFavoriate;
    final url =
        'https://collectionapp1-84046.firebaseio.com/collection/$id.json';
    isFavoriate = !isFavoriate;
    notifyListeners();
    try {
      final response = await http.patch(
        url,
        body: json.encode({'isFavoriate': isFavoriate}),
      );
      if (response.statusCode >= 400) {
        isFavoriate = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavoriate = oldStatus;
      notifyListeners();
      throw HttpException('Cannot favoriate');
    }
  }
}
