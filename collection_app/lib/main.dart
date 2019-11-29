import 'package:flutter/material.dart';
import './Screens/collect_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'collect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
