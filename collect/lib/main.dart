import 'package:collect/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Collection App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.lightBlue,
          canvasColor: Colors.lightGreen[50],
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(fontSize: 15, color: Colors.black),
              body2: TextStyle(color: Colors.black),
              title: TextStyle(
                fontSize: 17,
                fontFamily: 'Montserrat',
              ),
              subtitle: TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
                color: Colors.grey,
              ),
              display1: TextStyle(fontSize: 15, fontFamily: 'Monteserrat'),
              caption: TextStyle(fontSize: 13))),
      home: Home(),
    );
  }
}
