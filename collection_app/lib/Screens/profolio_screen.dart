import 'package:flutter/material.dart';

class ProfolioCart extends StatelessWidget {
  static const routeName = "/profolio";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profolio Screen'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8),
            ),
          ),
          FlatButton(
            child: Text("Start Challenge"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
