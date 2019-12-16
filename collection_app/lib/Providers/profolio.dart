import 'package:flutter/material.dart';

class ProfolioItem {
  final String id;
  final String title;
  final String imageUrl;

  ProfolioItem({@required this.id, @required this.title, @required this.imageUrl});
}

class Profolio with ChangeNotifier {
  Map<String, ProfolioItem> _items = {};

  Map<String, ProfolioItem> get items {
    return {..._items};
  }

  int get profolioSize {
    return _items.length;
  }

  void addItem(String id, String title, String imageUrl) {
    _items.putIfAbsent(
        id, () => ProfolioItem(id: DateTime.now().toString(), title: title, imageUrl: imageUrl));
    notifyListeners();
  }

  void removeItem(String id){
    _items.remove(id);
    notifyListeners();
  }
}
