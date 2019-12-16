import 'package:flutter/material.dart';
import '../Screens/item_detail_screen.dart';
import 'package:provider/provider.dart';
import '../Providers/collection.dart';
import '../Providers/profolio.dart';

class CollectionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profolio = Provider.of<Profolio>(context);

    return Consumer<Collection>(
      builder: (ctx, item, child) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ItemDetailScreen.routeName, arguments: item.id);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(item.title,
                      style: Theme.of(context).textTheme.title)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: item.isFavoriate
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      iconSize: 17,
                      onPressed: item.selectFavoriate,
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      iconSize: 17,
                      onPressed: () {
                        profolio.addItem(item.id, item.title, item.imageUrl);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
