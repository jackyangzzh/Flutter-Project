import '../Providers/collection.dart';
import 'package:flutter/material.dart';
import './collection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Collection> _items = [
    Collection(
      id: 'p1',
      title: 'Date night at 95th floor',
      location: 'Chicago',
      imageUrl:
          'https://i.pinimg.com/originals/e9/24/04/e924041a661fcc6edcc87998dc8443bd.jpg',
      description:
          'A great date place in Chicago. The view was breathtaking. The food is average tho',
    ),
    Collection(
      id: 'p2',
      title: 'Catching fall color',
      location: 'Devil\'s Lake',
      imageUrl:
          'https://dnr.wi.gov/topic/Parks/name/devilslake/images/tourism-balance-rock700x300.jpg',
      description:
          'I was able to watch sunset on Devil\'s Lake. It was absolutely beautiful',
    ),
    Collection(
      id: 'p3',
      title: 'Brunch at top of Chicago Athletic Association!',
      location: 'Chicago',
      imageUrl:
          'https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/07/Cindys-Rooftop-view-1200x900.jpg',
      description:
          'So hard to get a spot, but it totally lives up to the hype!',
    ),
  ];

  var isFavoriate = false;

  List<Collection> get items {
    return [..._items];
  }

  List<Collection> get favoriateItem {
    return _items.where((i) => i.isFavoriate).toList();
  }

  Collection findById(String id) {
    return items.firstWhere((index) => index.id == id);
  }

  Future<void> addItem(Collection item) {
    const url = 'https://collectionapp1-84046.firebaseio.com/collection.json';
    return http
        .post(url,
            body: json.encode({
              'title': item.title,
              'location': item.location,
              'description': item.description,
              'imageUrl': item.imageUrl,
              'isFavoriate': item.isFavoriate,
            }))
        .then((response) {
      final newItem = Collection(
          id: DateTime.now().toString(),
          title: item.title,
          description: item.description,
          imageUrl: item.imageUrl,
          location: item.location);
      _items.insert(0, newItem);
      notifyListeners();
    }).catchError((error) {
      throw (error);
    });
  }

  void updateItem(String id, Collection newItem) {
    final index = _items.indexWhere((i) => i.id == id);
    _items[index] = newItem;
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((i) => i.id == id);
    notifyListeners();
  }
}
