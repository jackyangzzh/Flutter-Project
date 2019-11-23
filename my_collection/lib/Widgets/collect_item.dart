import 'package:flutter/material.dart';
import '../Model/collection.dart';

class CollectItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String location;
  final Difficulty difficulty;

  CollectItem(
      {@required this.title,
      @required this.imageUrl,
      this.location,
      @required this.difficulty});

      String get getDifficulty {
        
      }

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
                ),
                Positioned(
                  bottom: 10,
                  left: 5,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 5,
                      ),
                      location == null
                          ? Text('No Location')
                          : Text(
                              '$location',
                              style: TextStyle(fontSize: 13),
                            ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 5,
                      ),
                      location == null
                          ? Text('No Location')
                          : Text(
                              '$location',
                              style: TextStyle(fontSize: 13),
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
