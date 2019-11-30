import 'package:flutter/material.dart';
import './Screens/collect_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Collection App',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.yellowAccent,
          canvasColor: Colors.lightGreen[50],
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(fontSize: 15, color: Colors.black),
              body2: TextStyle(color: Colors.black),
              title: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',),
              subtitle: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.grey,
              ),
              caption: TextStyle(fontSize: 13))),
      home: CollectOverviewScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('collect'),
      ),
      body: Center(
        child: Text('Let\'s build a collection!'),
      ),
    );
  }
}
