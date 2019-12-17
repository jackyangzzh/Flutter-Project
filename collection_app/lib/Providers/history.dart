import 'package:flutter/foundation.dart';
import './profolio.dart';

class HistoryItem {
  final String id;
  final int amount;
  final List<ProfolioItem> items;
  final DateTime dateTime;

  HistoryItem(
      {@required this.id,
      @required this.amount,
      @required this.items,
      @required this.dateTime});
}

class History with ChangeNotifier {
  List<HistoryItem> _items = [];

  List<HistoryItem> get getHistory {
    return [..._items];
  }

  void addHistory(List<ProfolioItem> profolioItem, int amount) {
    _items.insert(
        0,
        HistoryItem(
            id: DateTime.now().toString(),
            amount: amount,
            items: profolioItem,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
