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
                title: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
                subtitle: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                ),
                caption: TextStyle(fontSize: 13, color: Colors.grey[600]),
                display1: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monteserrat'),
                display2: TextStyle(
                    fontSize: 17,
                    color: Colors.black),
                display3: TextStyle(fontSize: 12, color: Colors.grey[700]),
                display4: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                headline: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              )),
      home: Home(),
    );
  }
}
