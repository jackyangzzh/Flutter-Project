import 'package:flutter/material.dart';
import 'package:my_collection/Screens/favoriate_screen.dart';
import './category_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Bar'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Category',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favoriate',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[CategoryScreen(), FavoriateScreen()],
        ),
      ),
    );
  }
}
