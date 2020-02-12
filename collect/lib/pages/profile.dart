import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/models/user.dart';
import 'package:collect/pages/edit_profile.dart';
import 'package:collect/pages/home.dart';
import 'package:collect/pages/timeline.dart';
import 'package:collect/widgets/header.dart';
import 'package:collect/widgets/post.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Profile extends StatefulWidget {
  final String profileId;

  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String currentUserId = currentUser?.id;
  bool isLoading = false;
  int postCount;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  void getPosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postRef
        .document(widget.profileId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    setState(() {
      postCount = snapshot.documents.length;
      posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
      isLoading = false;
    });
  }

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
            Hero(
              tag: 'userProfile',
              child: CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 2),
              child: Text(
                user.displayName,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(user.username,
                  style: Theme.of(context).textTheme.display3),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.only(bottom: 20),
              child: Text(user.bio,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display4),
            ),
            buildProfileButton(),
            Divider(),
          ]),
        );
      },
    );
  }

  void editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(
                  currentUserId: currentUserId,
                )));
  }

  Widget buildProfileButton() {
    bool isProfileOwn = currentUserId == widget.profileId;
    if (isProfileOwn) {
      return buildButton(text: "Edit Profile", function: editProfile);
    }
    return Text("Profile Button");
  }

  Container buildButton({String text, Function function}) {
    return Container(
        width: 120,
        height: 25,
        child: FlatButton(
          onPressed: function,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(5)),
          ),
        ));
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

  Widget buildPosts() {
    if (isLoading) {
      return circularProgress(context);
    }

    return Container(
      child: StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(3),
        crossAxisCount: 4,
        itemCount: postCount,
        itemBuilder: (_, i) => Post(
            postId: posts[i].postId,
            ownerId: posts[i].ownerId,
            username: posts[i].username,
            location: posts[i].location,
            caption: posts[i].caption,
            description: posts[i].description,
            timestamp: posts[i].timestamp,
            mediaUrl: posts[i].mediaUrl,
            likes: posts[i].likes),
        staggeredTileBuilder: (i) => new StaggeredTile.fit(2),
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: false,
              pinned: false,
              title: Text("Profile"),
            ),
            new SliverPadding(
              padding: new EdgeInsets.all(0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate([
                buildProfileHeader(),
              ])),
            ),
          ];
        },
        body: buildPosts(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: header(context,
  //         isTitle: false, titleText: "Profile", removeButton: true),
  //     body: Column(
  //       children: <Widget>[
  //         buildProfileHeader(),
  //         Divider(
  //           height: 0,
  //         ),
  //         buildPosts()
  //       ],
  //     ),
  //   );
  // }
}
