import 'package:flutter/material.dart';
import '../Screens/edit_collection_screen.dart';
import 'package:provider/provider.dart';
import '../Providers/product_provider.dart';

class UserCollectionItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final String description;

  UserCollectionItem(
      this.id, this.title, this.imageUrl, this.location, this.description);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Text(title, style: Theme.of(context).textTheme.display1)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                  iconSize: 17,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        EditCollectionScreen.routeName,
                        arguments: id);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  iconSize: 17,
                  onPressed: () async {
                    try {
                      await Provider.of<ProductProvider>(context, listen: false)
                          .deleteItem(id);
                    } catch (error) {
                      scaffold.showSnackBar(
                          SnackBar(content: Text('Failed to delete')));
                    }
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
    );
  }
}
