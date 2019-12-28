import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Providers/history.dart';

class PastCollection extends StatelessWidget {
  final HistoryItem pastCollection;
  PastCollection(this.pastCollection);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title:
                Text(DateFormat('MM/dd/yyyy').format(pastCollection.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
