import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import './collection_item.dart';

class ItemGrid extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    Provider.of(context);
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(3),
        crossAxisCount: 4,
        itemCount: dummyData.length,
        itemBuilder: (context, i) => CollectionItem(
             dummyData[i].imageUrl, dummyData[i].id, dummyData[i].title, dummyData[i].description),
        staggeredTileBuilder: (i) => new StaggeredTile.fit(2),
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      );
  }
}