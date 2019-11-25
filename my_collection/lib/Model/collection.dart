import 'package:flutter/foundation.dart';

enum Difficulty {
  Easy,
  Average,
  Challenging,
  Hard,
}

enum Mood {
  Miserable,
  Disappointing,
  Average,
  Happy,
  Amazing,
}

class Collection {
  final String id;
  final List<String> categories;
  final String title;
  final String location;
  final String imageUrl;
  final String description;
  final Difficulty difficulty;
  final Mood mood;
  final bool wouldAgain;
  final bool wouldRecommand;

  const Collection(
      {@required this.id,
      @required this.categories,
      @required this.title,
      this.location,
      @required this.imageUrl,
      @required this.description,
      @required this.difficulty,
      @required this.mood,
      @required this.wouldAgain,
      @required this.wouldRecommand});
}
