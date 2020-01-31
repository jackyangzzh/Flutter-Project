import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/models/user.dart';
import 'package:collect/pages/activity_feed.dart';
import 'package:collect/pages/create_account.dart';
import 'package:collect/pages/profile.dart';
import 'package:collect/pages/search.dart';
import 'package:collect/pages/timeline.dart';
import 'package:collect/pages/upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final userRef = Firestore.instance.collection('users');
final DateTime timeStamp = DateTime.now();
User currentUser;

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

    // _googleSignIn.onCurrentUserChanged.listen((account) {
    //   signInHandler(account);
    // }, onError: (error) {
    //   print("Error when sigin in: " + error);
    // });

    // _googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   signInHandler(account);
    // }).catchError((error) {
    //   print("Error when silent sigin in: " + error);
    // });

    _googleSignIn.onCurrentUserChanged.listen((account) {
      signInHandler(account);
    }, onError: (error) {
      print("Error when sigin in: " + error);
    });
    _googleSignIn.signInSilently();
  }

  void signInHandler(GoogleSignInAccount account) {
    if (account != null) {
      createUser();
      setState(() {
        _isAuth = true;
      });
    } else {
      setState(() {
        _isAuth = false;
      });
    }
  }

  void createUser() async {
    final GoogleSignInAccount user = _googleSignIn.currentUser;
    DocumentSnapshot userInfo = await userRef.document(user.id).get();

    if (!userInfo.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      userRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timeStamp,
      });
      userInfo = await userRef.document(user.id).get();
    }
    currentUser = User.fromDocument(userInfo);
    print(currentUser.username);
  }

  void signIn() {
    _googleSignIn.signIn();
  }

  void signOut() {
    _googleSignIn.signOut();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      this._index = index;
    });
  }

  void pageChangeTap(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
  }

  Scaffold authScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          // Timeline(),
          FlatButton(
            child: Text("logout"),
            onPressed: signOut,
          ),

          ActivityFeed(),
          Upload(),
          Search(),
          Profile()
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _index,
        onTap: pageChangeTap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.group), title: Text('Timeline')),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.notifications), title: Text('Feed')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
                size: 45,
              ),
              title: Text('Camera')),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.search), title: Text('Search')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
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
