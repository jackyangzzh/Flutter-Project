import 'package:flutter/material.dart';
import '../Model/collection.dart';
import '../Widgets/collect_item.dart';

class FavoriateScreen extends StatelessWidget {
  final List<Collection> favoriateItem;
  FavoriateScreen(this.favoriateItem);

  @override
  Widget build(BuildContext context) {
    if (favoriateItem.isEmpty) {
      return Center(
        child: Text('So empty right now -- Add some favoriates!'),
      );
    }
    else{
      return ListView.builder(
        itemBuilder: (ctx, i) {
          return CollectItem(
            id: favoriateItem[i].id,
            title: favoriateItem[i].title,
            imageUrl: favoriateItem[i].imageUrl,
            location: favoriateItem[i].location,
            mood: favoriateItem[i].mood,
            difficulty: favoriateItem[i].difficulty,
          );
        },
        itemCount: favoriateItem.length,
      );
  }
}
}
