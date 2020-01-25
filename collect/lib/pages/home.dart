import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((account) {
      signInHandler(account);
    }, onError: (error) {
      print("Error when sigin in: " + error);
    });

    _googleSignIn.signInSilently(suppressErrors: false).then((account) {
      signInHandler(account);
    }).catchError((error) {
      print("Error when silent sigin in: " + error);
    });
  }

  signInHandler(GoogleSignInAccount account) {
    if (account != null) {
      print(account);
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  signIn() {
    _googleSignIn.signIn();
  }

  signOut() {
    _googleSignIn.signOut();
  }

  Widget authScreen() {
    return FlatButton(
      child: Text("Log out"),
      onPressed: signOut,
    );
  }

  Scaffold unAuthScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Collect',
              style: TextStyle(
                  fontFamily: "funFont", fontSize: 90, color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: signIn,
              child: Container(
                  width: 180,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/google_signin_button.png'),
                          fit: BoxFit.cover))),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? authScreen() : unAuthScreen();
  }
}
