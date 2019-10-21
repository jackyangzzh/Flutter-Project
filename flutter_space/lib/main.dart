import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      {
        'questionText': 'What\'s your favoriate color?',
        'answers': ['Red', 'Green', 'Black']
      },
      {
        'questionText': 'What sports do you play?',
        'answers': ['Basketball', 'Soccer', 'Football'],
      },
      {
        'questionText': 'What\'s your favoriate brand?',
        'answers': ['Gucci', 'Fear of God', 'Off White'],
      }
    ];
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('My Flutter App'),
          ),
          body: Column(
            children: [
              Question(questions[_questionIndex]),
              Answer(_answerQuestion),
              Answer(_answerQuestion),
              Answer(_answerQuestion),
            ],
          )),
    );
  }
}
