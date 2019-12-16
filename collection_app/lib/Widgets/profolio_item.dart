import 'package:flutter/material.dart';

class ProfolioItem extends StatelessWidget {
  final String id;
  final String title;

  ProfolioItem(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(title: Text(title),),
      ),
    );
  }
}
