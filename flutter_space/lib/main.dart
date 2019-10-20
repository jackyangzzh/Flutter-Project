import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void answerQuestion() {
    print('Answer chosen!');
  }

  @override
  Widget build(BuildContext context) {
    var question = [
      'What\'s your favorite food?',
      'What sports do you play?',
      'What\'s your favoriate designer',
    ];
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('My Flutter App'),
          ),
          body: Column(
            children: [
              Text('Question here'),
              RaisedButton(child: Text('Answer 1'),onPressed: null),
              RaisedButton(child: Text('Answer 2'),onPressed: null,),
              RaisedButton(child: Text('Anwer 3'),),
              RaisedButton(child: Text('Answer 4'),),
            ],
          )
          ),
    );
  }
}
