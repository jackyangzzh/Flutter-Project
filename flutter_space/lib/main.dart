import 'package:flutter/material.dart';
import 'package:flutter_space/result.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What\'s your favoriate color?',
      'answers': [
        {'text': 'Red', 'score': 0},
        {'text': 'Green', 'score': 0},
        {'text': 'Black', 'score': 2},
        {'text': 'White', 'score': 1}
      ],
    },
    {
      'questionText': 'What sports do you like the best?',
      'answers': [
        {'text': 'Basketball', 'score': 2},
        {'text': 'Baseball', 'score': 0},
        {'text': 'Soccer', 'score': 1},
        {'text': 'Football', 'score': 1}
      ],
    },
    {
      'questionText': 'What\'s your favoriate DC character?',
      'answers': [
        {'text': 'Batman', 'score': 0},
        {'text': 'Green Arrow', 'score': 1},
        {'text': 'Joker', 'score': 2},
        {'text': 'Superman', 'score': 0}
      ],
    },
    {
      'questionText': 'What\'s your favoriate food?',
      'answers': [
        {'text': 'Burger', 'score': 1},
        {'text': 'Pizza', 'score': 0},
        {'text': 'Ramen', 'score': 1},
        {'text': 'Fried chicken', 'score': 2}
      ],
    }, 
    {
      'questionText': 'What\'s your favoriate musician?',
      'answers': [
        {'text': 'Kanye West', 'score': 2},
        {'text': 'Justin Bieber', 'score': 0},
        {'text': 'Drake', 'score': 1},
        {'text': 'Taylor Swift', 'score': 0}
      ],
    }
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('How similiar are you?'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questions: _questions,
                questionIndex: _questionIndex)
            : Result(_totalScore * 10, _resetQuiz),
      ),
    );
  }
}
