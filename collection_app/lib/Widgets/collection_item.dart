import 'package:flutter/material.dart';

class CollectionItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String title;

  CollectionItem(this.imageUrl, this.id, this.title);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: FittedBox(child: Image.network(imageUrl), fit: BoxFit.cover), 
    );
  }
}