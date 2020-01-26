import 'package:flutter/material.dart';

AppBar header(context, {bool isTitle = false}) {
  return AppBar(
    
    centerTitle: true,
     title: isTitle ? Text(
      'Collect',
      style:
          TextStyle(fontFamily: "funFont", fontSize: 40, color: Colors.white),
    ) : Text('Profile', style: TextStyle(fontSize: 25),)
  );
}
