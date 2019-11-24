import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-detail';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final _itemId = routeArgs['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Text('Item Screen'),
    );
  }
}
