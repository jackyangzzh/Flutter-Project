import 'package:flutter/material.dart';
import '../Model/collection.dart';

class CollectItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Difficulty difficulty;

  CollectItem(
      {@required this.title,
      @required this.imageUrl,
      @required this.difficulty});

  @override
  Widget build(BuildContext context) {
    void selectItem() {}

    return InkWell(
      onTap: selectItem,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
