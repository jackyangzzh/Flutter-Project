import 'package:flutter/material.dart';
import '../dummy_data.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-detail';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final _itemId = routeArgs['id'];
    print(_itemId);
    final _selectedItem = dummyCollection.firstWhere((item) => item.id == _itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(_selectedItem.imageUrl),
          )
        ],
      ),
    );
  }
}
