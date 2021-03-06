import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../Screens/item_detail_screen.dart';
import '../Model/collection.dart';

class CollectItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final Difficulty difficulty;
  final Mood mood;
  final Function remove;

  CollectItem(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.mood,
      this.location,
      @required this.difficulty,
      @required this.remove});

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

  void selectItem(BuildContext context) {
    Navigator.of(context).pushNamed(ItemDetailScreen.routeName, arguments: {
      'id': id
    }).then((result) => {if (result != null) remove(result)});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectItem(context),
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
                    height: MediaQuery.of(context).size.width * 0.55,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
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
