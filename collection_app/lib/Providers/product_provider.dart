import '../Providers/collection.dart';
import 'package:flutter/material.dart';
import './collection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/HttpException.dart';

class ProductProvider with ChangeNotifier {
  List<Collection> _items = [
    // Collection(
    //   id: 'p1',
    //   title: 'Date night at 95th floor',
    //   location: 'Chicago',
    //   imageUrl:
    //       'https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/10/The-Signature-Room-at-the-95th.jpg',
    //   description:
    //       'A great date place in Chicago. The view was breathtaking. The food is average tho',
    // ),
    // Collection(
    //   id: 'p2',
    //   title: 'Catching fall color',
    //   location: 'Devil\'s Lake',
    //   imageUrl:
    //       'https://www.wisdells.com/member-media/attr/devils_lake_state_park_01.jpg',
    //   description:
    //       'I was able to watch sunset on Devil\'s Lake. It was absolutely beautiful',
    // ),
    // Collection(
    //   id: 'p3',
    //   title: 'Brunch at top of Chicago Athletic Association!',
    //   location: 'Chicago',
    //   imageUrl:
    //       'https://d36tnp772eyphs.cloudfront.net/blogs/1/2018/07/Cindys-Rooftop-view-1200x900.jpg',
    //   description:
    //       'So hard to get a spot, but it totally lives up to the hype!',
    // ),
  ];

  var isFavoriate = false;
  final String userId;
  final String authToken;

  ProductProvider(this.authToken, this.userId, this._items);

  List<Collection> get items {
    return [..._items];
  }

  List<Collection> get favoriateItem {
    return _items.where((i) => i.isFavoriate).toList();
  }

  Collection findById(String id) {
    return items.firstWhere((index) => index.id == id);
  }

  Future<void> fetchData([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        'https://collectionapp1-84046.firebaseio.com/collection.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Collection> loadedData = [];
      if (data == null) {
        return;
      }

      final userUrl =
          'https://collectionapp1-84046.firebaseio.com/userFavoriate/$userId.json?auth=$authToken';
      final favoriateResponse = await http.get(userUrl);
      final favoriateData = json.decode(favoriateResponse.body);
      data.forEach((id, info) {
        loadedData.insert(
            0,
            Collection(
                id: id,
                title: info['title'],
                description: info['description'],
                location: info['location'],
                imageUrl: info['imageUrl'],
                isFavoriate: favoriateData == null
                    ? false
                    : favoriateData[id] ?? false));
      });
      _items = loadedData;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addItem(Collection item) async {
    final url =
        'https://collectionapp1-84046.firebaseio.com/collection.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': item.title,
            'location': item.location,
            'description': item.description,
            'imageUrl': item.imageUrl,
            'creatorId': userId
          }));
      final newItem = Collection(
          id: DateTime.now().toString(),
          title: item.title,
          description: item.description,
          imageUrl: item.imageUrl,
          location: item.location);
      _items.insert(0, newItem);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateItem(String id, Collection newItem) async {
    final index = _items.indexWhere((i) => i.id == id);
    final url =
        'https://collectionapp1-84046.firebaseio.com/collection/$id.json?auth=$authToken';
    await http.patch(url,
        body: json.encode({
          'title': newItem.title,
          'description': newItem.description,
          'location': newItem.location,
          'imageUrl': newItem.imageUrl
        }));
    _items[index] = newItem;
    notifyListeners();
  }

  Future<void> deleteItem(String id) async {
    final url =
        'https://collectionapp1-84046.firebaseio.com/collection/$id.json?auth=$authToken';
    final deleteIndex = _items.indexWhere((i) => i.id == id);
    var deleteItem = _items[deleteIndex];
    _items.removeAt(deleteIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(deleteIndex, deleteItem);
      notifyListeners();
      throw (HttpException('Could not delete'));
    }
    deleteItem = null;
  }
}
