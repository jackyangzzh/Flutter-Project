import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/models/user.dart';
import 'package:collect/pages/home.dart';
import 'package:collect/widgets/progress.dart';
import "package:flutter/material.dart";
import 'home.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({this.currentUserId});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  User user;
  bool _displayNameValid = true;
  bool _bioValid = true;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await userRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    displayNameController.text = user.displayName;
    bioController.text = user.bio;
    setState(() {
      isLoading = false;
    });
  }

  Widget buildDisplayName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              "Display name",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          TextField(
            controller: displayNameController,
            decoration: InputDecoration(
                hintText: "What's your name?",
                errorText: _displayNameValid ? null : "Try a longer name"),
          )
        ],
      ),
    );
  }

  Widget buildBio() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              "Bio",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          TextField(
            controller: bioController,
            maxLines: 2,
            decoration: InputDecoration(
                hintText: "Something about yourself",
                errorText: _bioValid ? null : "Try a shorter bio"),
          )
        ],
      ),
    );
  }

  void updateProfileData() {
    setState(() {
      displayNameController.text.trim().length < 3 ||
              displayNameController.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;
      bioController.text.trim().length > 80
          ? _bioValid = false
          : _bioValid = true;
    });

    if (_displayNameValid && _bioValid) {
      userRef.document(widget.currentUserId).updateData({
        "displayName": displayNameController.text,
        "bio": bioController.text
      });
      SnackBar snackBar = SnackBar(content: Text("Profile Updated"));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  void logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Edit Profile"), actions: <Widget>[
        IconButton(icon: Icon(Icons.done), onPressed: updateProfileData)
      ]),
      body: isLoading
          ? circularProgress(context)
          : Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Hero(
                      tag: 'userProfile',
                      child: CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(user.photoUrl),
                        radius: 50,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Column(
                        children: <Widget>[buildDisplayName(), buildBio()]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                        width: 140,
                        height: 40,
                        child: FlatButton(
                          onPressed: updateProfileData,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Update",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.green[600],
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                        width: 120,
                        height: 40,
                        child: FlatButton.icon(
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                          onPressed: logout,
                          label: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Log Out",
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
    );
  }
}
