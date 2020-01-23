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
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? widget.pastCollection.items.length * 80.0 + 90 : 80,
      child: Card(
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
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded
                  ? widget.pastCollection.items.length * 80.0 + 10
                  : 0,
              child: ListView(
                children: widget.pastCollection.items
                    .map((i) => Card(
                          elevation: 1,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: ListTile(
                              leading: Container(
                                width: 100,
                                height: 100,
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
      ),
    );
  }
}
