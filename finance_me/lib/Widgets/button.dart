import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class button extends StatelessWidget {
  final String text;
  final Function _func;

  const button(this.text, this._func);

  @override
  Widget build(BuildContext context) {
    return 
       Platform.isIOS
                  ? CupertinoButton(
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: _func,
                    )
                  : FlatButton(
                      color: Theme.of(context).primaryColorDark,
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: _func,
                    );
  }
}