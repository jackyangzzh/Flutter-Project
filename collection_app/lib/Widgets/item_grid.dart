import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import './collection_item.dart';
import '../Providers/product_provider.dart';

class ItemGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemsData = Provider.of<ProductProvider>(context);
    final items = itemsData.items;
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(3),
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (context, i) => ChangeNotifierProvider(
        builder: (c) => items[i],
        child: CollectionItem(),
      ),
      staggeredTileBuilder: (i) => new StaggeredTile.fit(2),
      mainAxisSpacing: 3,
      crossAxisSpacing: 3,
    );
  }
}
