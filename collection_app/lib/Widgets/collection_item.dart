import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CollectionItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String title;

  CollectionItem(this.imageUrl, this.id, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                Text(title,),
            ],
      ),
    );
  }
}
