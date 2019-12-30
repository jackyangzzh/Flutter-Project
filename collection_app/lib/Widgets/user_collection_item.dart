import 'package:flutter/material.dart';

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
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  iconSize: 17,
                  onPressed: () {},
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
