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
                Color.fromRGBO(255, 255, 102, 1).withOpacity(0.4),
                Color.fromRGBO(102, 255, 102, 1).withOpacity(0.7),
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
                  Container(
                    child: Text('Collect',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.title.color,
                            fontSize: 50,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    child: Text('Own your experience',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.title.color,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.05,
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
