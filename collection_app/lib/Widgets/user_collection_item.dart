import 'package:flutter/material.dart';
import '../Screens/item_detail_screen.dart';

class UserCollectionItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String location;
  final String description;

  UserCollectionItem(
      this.title, this.imageUrl, this.location, this.description);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                      style: Theme.of(context).textTheme.display1)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}
