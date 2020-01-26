import 'package:flutter/material.dart';

Container circularProgress(context) {
  return Container(
      child: Center(
          child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
  )));
}

linearProgress(context) {
  return Container(
      child: LinearProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
  ));
}
