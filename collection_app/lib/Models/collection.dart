import 'package:flutter/foundation.dart';

enum Mood {
  Miserable,
  Disappointing,
  Average,
  Happy,
  Amazing,
}

class Collection {
  final String id;
  final String title;
  final String location;
  final double score;
  final String imageUrl;
  final Mood mood;
  bool isFavoriate;

  Collection(
      {@required this.id,
      @required this.title,
      this.location,
      @required this.mood,
      @required this.score,
      @required this.imageUrl,
      this.isFavoriate = false});
}
