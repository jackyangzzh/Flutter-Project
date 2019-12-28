import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../Providers/history.dart';

class PastCollection extends StatefulWidget {
  final HistoryItem pastCollection;
  PastCollection(this.pastCollection);

  @override
  _PastCollectionState createState() => _PastCollectionState();
}

class _PastCollectionState extends State<PastCollection> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(DateFormat('MM/dd/yyyy')
                .format(widget.pastCollection.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(
                  widget.pastCollection.items.length * 20.0 +
                      MediaQuery.of(context).size.height * 0.1,
                  MediaQuery.of(context).size.height * 0.5),
              child: ListView(
                children: widget.pastCollection.items
                    .map((i) => Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: ListTile(
                              leading: Container(
                                child: Image.network(
                                  i.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(i.title,
                                  style: Theme.of(context).textTheme.display1),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
