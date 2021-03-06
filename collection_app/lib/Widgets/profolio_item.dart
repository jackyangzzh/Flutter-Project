import 'package:flutter/material.dart';
import '../Providers/profolio.dart';
import 'package:provider/provider.dart';

class ProfolioItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final String imageUrl;

  ProfolioItem(this.id, this.productId, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 20),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Deleting"),
                  content: Text("Are you sure you want to delete this?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                    ),
                    FlatButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        }),
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Profolio>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
            leading: Container(
              width: 100,
              height: 100,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(title, style: Theme.of(context).textTheme.display1),
          ),
        ),
      ),
    );
  }
}
