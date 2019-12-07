import 'package:flutter/material.dart';

class ProfolioItem {
  final String id;
  final String title;

  ProfolioItem({@required this.id, @required this.title});
}

class Profolio with ChangeNotifier {
  Map<String, ProfolioItem> _items;

  Map<String, ProfolioItem> get items {
    return {..._items};
  }

  void addItem(String id, String title) {
    _items.putIfAbsent(
        id, () => ProfolioItem(id: DateTime.now().toString(), title: title));
  }
}
