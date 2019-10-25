import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function select;
  final String answer;
  
  Answer(this.select, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.lightBlue[100],
        child: Text(answer),
        onPressed: select,
      ),
    );
  }
}
