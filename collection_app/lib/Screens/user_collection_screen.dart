import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/product_provider.dart';
import '../Widgets/user_collection_item.dart';

class UserCollectionScreen extends StatelessWidget {
  static const routeName = '/userCollection';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Collection'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) => UserCollectionItem(
              productData.items[i].title,
              productData.items[i].imageUrl,
              productData.items[i].location,
              productData.items[i].description),
        ),
      ),
    );
  }
}
