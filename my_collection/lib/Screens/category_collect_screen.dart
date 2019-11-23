import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../Widgets/collect_item.dart';

class CategoryCollectScreen extends StatelessWidget {
  static const routeName = '/collection_page';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final _categoryTitle = routeArgs['title'];
    final _categoryID = routeArgs['id'];
    final _categoryItem = dummyCollection.where((item) {
      return item.categories.contains(_categoryID);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return CollectItem(
              title: _categoryItem[i].title,
              imageUrl: _categoryItem[i].imageUrl,
              location: _categoryItem[i].location,
              mood: _categoryItem[i].mood,
              difficulty: _categoryItem[i].difficulty);
        },
        itemCount: _categoryItem.length,
      ),
    );
  }
}
