import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/models/user.dart';
import 'package:collect/pages/home.dart';
import 'package:collect/widgets/progress.dart';
import "package:flutter/material.dart";

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({this.currentUserId});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  User user;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.done),
          onPressed: () => Navigator.pop(context),
        )
      ]),
      body: isLoading ? circularProgress(context) : Text("Hi"),
    );
  }
}
