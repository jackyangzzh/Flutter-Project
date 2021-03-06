import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../Providers/product_provider.dart';
import '../Widgets/user_collection_item.dart';
import '../Widgets/app_drawer.dart';
import './edit_collection_screen.dart';

class UserCollectionScreen extends StatelessWidget {
  static const routeName = '/userCollection';

  Future<void> _refresh(BuildContext context) async {
    Provider.of<ProductProvider>(context, listen: false).fetchData(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Collection'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditCollectionScreen.routeName);
              },
            )
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _refresh(context),
            builder: (ctx, i) => i.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refresh(context),
                    child: Consumer<ProductProvider>(
                      builder: (ctx, productData, _) => StaggeredGridView.countBuilder(
                        padding: const EdgeInsets.all(3),
                        crossAxisCount: 4,
                        itemCount: productData.items.length,
                        itemBuilder: (_, i) => UserCollectionItem(
                          productData.items[i].id,
                          productData.items[i].title,
                          productData.items[i].imageUrl,
                          productData.items[i].location,
                          productData.items[i].description,
                        ),
                        staggeredTileBuilder: (i) => new StaggeredTile.fit(2),
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                      ),
                    ),
                  )));
  }
}
