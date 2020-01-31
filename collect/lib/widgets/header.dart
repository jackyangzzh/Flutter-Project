import 'package:flutter/material.dart';

AppBar header(context,
    {bool isTitle = false, String titleText, removeButton = false}) {
  return AppBar(
      automaticallyImplyLeading: removeButton,
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
