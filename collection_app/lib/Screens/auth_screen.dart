import 'dart:math';
import 'package:flutter/material.dart';
import '../Widgets/auth_card.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(255, 255, 102, 1).withOpacity(0.5),
                Color.fromRGBO(102, 255, 102, 1).withOpacity(0.9)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1],
            )),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.green.shade900,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black26,
                                offset: Offset(0, 2))
                          ]),
                      child: Text('Collect',
                          style: TextStyle(
                              color:
                                  Theme.of(context).accentTextTheme.title.color,
                              fontSize: 50,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
