import 'package:collect/pages/activity_feed.dart';
import 'package:collect/pages/profile.dart';
import 'package:collect/pages/search.dart';
import 'package:collect/pages/timeline.dart';
import 'package:collect/pages/upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isAuth = false;
  int _index = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  signInHandler(GoogleSignInAccount account) {
    if (account != null) {
      print(account);
      setState(() {
        _isAuth = true;
      });
    } else {
      setState(() {
        _isAuth = false;
      });
    }
  }

  signIn() {
    _googleSignIn.signIn();
  }

  signOut() {
    _googleSignIn.signOut();
  }

  onPageChanged(int index) {
    setState(() {
      this._index = index;
    });
  }

  pageChangeTap(int index) {
    _pageController.jumpToPage(index);
  }

  Widget authScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile()
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _index,
        onTap: pageChangeTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.camera_alt,
            size: 50,
          )),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle))
        ],
      ),
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
    return _isAuth ? authScreen() : unAuthScreen();
  }
}
