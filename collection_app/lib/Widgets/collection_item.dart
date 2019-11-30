import 'package:flutter/material.dart';
import '../Screens/item_detail_screen.dart';

class CollectionItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String title;
  final String desciption;

  CollectionItem(this.imageUrl, this.id, this.title, this.desciption);

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.all(4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(ItemDetailScreen.routeName, arguments: id);
        },
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
                child: Text(title, style: Theme.of(context).textTheme.title)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    iconSize: 17,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    iconSize: 17,
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
