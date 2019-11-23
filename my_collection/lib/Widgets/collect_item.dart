import 'package:flutter/material.dart';
import '../Model/collection.dart';

class CollectItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String location;
  final Difficulty difficulty;
  final Mood mood;

  CollectItem(
      {@required this.title,
      @required this.imageUrl,
      @required this.mood,
      this.location,
      @required this.difficulty});

  String get getDifficulty {
    switch (difficulty) {
      case Difficulty.Easy:
        return 'Easy';
      case Difficulty.Average:
        return 'Average';
      case Difficulty.Challenging:
        return 'Challenging';
      case Difficulty.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get getMood {
    switch (mood) {
      case Mood.Disappointing:
        return 'Disappointing';
      case Mood.Miserable:
        return 'Miserable';
      case Mood.Happy:
        return 'Happy';
      case Mood.Average:
        return 'Average';
      case Mood.Amazing:
        return 'Amazing';
      default:
        return 'Unknown';
    }
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 5,
                      ),
                      location == null
                          ? Text('Mystery')
                          : Text(
                              '$location',
                              style: TextStyle(fontSize: 13),
                            ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.event_note),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$getDifficulty',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.mood),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$getMood',
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
