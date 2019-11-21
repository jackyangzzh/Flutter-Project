import 'package:flutter/material.dart';

class CategoryCollectScreen extends StatelessWidget {
  static const routeName = '/collection_page';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final _categoryTitle = routeArgs['title'];
    final _categoryID = routeArgs['id'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_categoryTitle),
      ),
      body: Container(
        child: Text('Welcome to the collection page'),
      ),
    );
  }
}
