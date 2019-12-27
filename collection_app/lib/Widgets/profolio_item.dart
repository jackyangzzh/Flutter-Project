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
      onDismissed: (direction) {
        Provider.of<Profolio>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
            leading: Container(
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
