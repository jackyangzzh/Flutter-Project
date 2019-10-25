import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    var resultText = 'You did it!';
    if (resultScore >= 70) {
      return resultText = 'We are very similiar ^_^';
    } else if (resultScore <= 30) {
      return resultText = 'We are not very alike :/';
    } else {
      return resultText = 'We are kinda alike =D';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          child: Text(
            'Try again',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: resetHandler,
          color: Colors.redAccent,
        )
      ],
    ));
  }
}
