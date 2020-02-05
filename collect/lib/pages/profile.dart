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
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
            Container(
              padding: EdgeInsets.all(3),
              child: Text(user.displayName, style: Theme.of(context).textTheme.title,),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 3),
              child: Text(user.username, style: Theme.of(context).textTheme.subtitle),
            ),
            buildProfileButton(),
          ]),
        );
      },
    );
  }

  Widget buildProfileButton(){
    return Text("Profile Button");
  }

  //used for building followers counter etc.
  Column buildCount(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(count.toString()),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(label, style: TextStyle(color: Colors.grey)),
        )
      ],
    );
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
