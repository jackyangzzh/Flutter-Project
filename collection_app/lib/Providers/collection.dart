import 'package:flutter/foundation.dart';

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
  final Mood mood;
  bool isFavoriate;

  Collection(
      {@required this.id,
      @required this.title,
      @required this.description,
      this.location,
      @required this.mood,
      @required this.imageUrl,
      this.isFavoriate = false});

  void selectFavoriate() {
    isFavoriate = !isFavoriate;
    notifyListeners();
  }
}
