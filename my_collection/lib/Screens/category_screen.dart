import 'package:flutter/material.dart';
import '../Widgets/category_item.dart';
import '../dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('My Collection',)),
        body: GridView(
          padding: EdgeInsets.all(15),
          children: dummyData
              .map((data) => CategoryItem(data.id, data.title, data.color))
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
        ));
  }
}
