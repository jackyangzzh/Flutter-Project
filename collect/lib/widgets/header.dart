import 'package:flutter/material.dart';

AppBar header(context, {bool isTitle = false, String titleText}) {
  return AppBar(
      centerTitle: true,
      title: isTitle
          ? Text(
              'Collect',
              style: TextStyle(
                  fontFamily: "funFont", fontSize: 40, color: Colors.white),
            )
          : Text(
              titleText,
              style: TextStyle(fontSize: 25),
            ));
}
