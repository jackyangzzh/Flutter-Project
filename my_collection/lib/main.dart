import 'package:flutter/material.dart';
import './category_screen.dart';

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
        canvasColor: Color.fromRGBO(255, 48, 48, 1),
      ),
      home: CategoryScreen(),
    );
  }
}
