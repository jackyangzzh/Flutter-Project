import 'package:cached_network_image/cached_network_image.dart';
import 'package:collect/models/user.dart';
import 'package:collect/pages/timeline.dart';
import 'package:collect/widgets/header.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String profileId;

  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget buildProfileHeader() {
    return FutureBuilder(
      future: usersRef.document(widget.profileId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            )
          ]),
        );
      },
    );
  }

  Column buildCount() {
    return Column();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          isTitle: false, titleText: "Profile", removeButton: true),
      body: ListView(children: <Widget>[
        buildProfileHeader(),
      ]),
    );
  }
}
