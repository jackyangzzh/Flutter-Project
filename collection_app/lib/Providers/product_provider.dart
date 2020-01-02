import '../Providers/collection.dart';
import 'package:flutter/material.dart';
import './collection.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Collection> _items = [
    Collection(
      id: 'p1',
      title: 'Date night at 95th floor',
      location: 'Chicago',
      imageUrl:
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577550045811&di=e8091726c3e775bf530a4c76392dc589&imgtype=0&src=http%3A%2F%2Fapp.chuanbudsp.com%2Fueditor%2Fphp%2Fupload%2Fimage%2F20180517%2F1526540559692924.png',
      description:
          'A great date place in Chicago. The view was breathtaking. The food is average tho',
    ),
    Collection(
      id: 'p2',
      title: 'Catching fall color',
      location: 'Devil\'s Lake',
      imageUrl:
          'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2445517187,3248153313&fm=26&gp=0.jpg',
      description:
          'I was able to watch sunset on Devil\'s Lake. It was absolutely beautiful',
    ),
    Collection(
      id: 'p3',
      title: 'Brunch at top of Chicago Athletic Association!',
      location: 'Chicago',
      imageUrl:
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578144808&di=0133bccc6e86ae98da280064c6e4e23e&imgtype=jpg&er=1&src=http%3A%2F%2Fp1.meituan.net%2Fpoicontent%2F19581e55aff2634551bd5a6bdbe62912168555.jpg',
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

  void addItem(Collection item) {
    final newItem = Collection(
        id: DateTime.now().toString(),
        title: item.title,
        description: item.description,
        imageUrl: item.imageUrl,
        location: item.location);
    _items.insert(0, newItem);
    notifyListeners();
  }

  void updateItem(String id, Collection newItem) {
    final index = _items.indexWhere((i) => i.id == id);
    _items[index] = newItem;
    notifyListeners();
  }

  void deleteItem(String id){
    _items.removeWhere((i) => i.id == id);
    notifyListeners(); 
  }
}
