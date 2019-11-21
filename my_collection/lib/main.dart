import 'package:flutter/material.dart';
import './category_screen.dart';
import './category_collect_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Collection App',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.redAccent,
          canvasColor: Color.fromRGBO(235, 255, 255, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Colors.black),
              body2: TextStyle(color: Colors.black),
              title: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600))),
      home: CategoryScreen(),
      routes: {
        CategoryCollectScreen.routeName: (ctx) => CategoryCollectScreen(),
      },
    );
  }
}
