import 'package:flutter/foundation.dart';
import './profolio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> fetchData() async {
    final url = 'https://collectionapp1-84046.firebaseio.com/history.json';
    final response = await http.get(url);
    final List<HistoryItem> loadedHistory = [];
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data == null) {
      return;
    }
    data.forEach((id, item) {
      loadedHistory.add(HistoryItem(
          id: id,
          amount: item['amount'],
          dateTime: DateTime.parse(item['dateTime']),
          items: (item['items'] as List<dynamic>)
              .map((i) => ProfolioItem(
                  id: i['id'],
                  title: i['title'],
                  imageUrl: i['imageUrl']))
              .toList()));
    });
    _items = loadedHistory.reversed.toList();
    notifyListeners();
  }

  void addHistory(List<ProfolioItem> profolioItem, int amount) async {
    final url = 'https://collectionapp1-84046.firebaseio.com/history.json';
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': amount,
          'dateTime': timeStamp.toIso8601String(),
          'items': profolioItem
              .map((i) => {
                    'id': i.id,
                    'title': i.title,
                    'imageUrl': i.imageUrl,
                  })
              .toList()
        }));
    _items.insert(
        0,
        HistoryItem(
            id: json.decode(response.body)['name'],
            amount: amount,
            items: profolioItem,
            dateTime: timeStamp));
    notifyListeners();
  }
}
