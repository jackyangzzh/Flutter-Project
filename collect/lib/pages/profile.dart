import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/models/user.dart';
import 'package:collect/pages/activity_feed.dart';
import 'package:collect/pages/edit_profile.dart';
import 'package:collect/pages/home.dart';
import 'package:collect/pages/timeline.dart';
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
  bool isFollowing = false;
  final String currentUserId = currentUser?.id;
  bool isLoading = false;
  int postCount;
  List<Post> posts = [];
  User user;
  int followerCount = 0;
  int followingCount = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    getPosts();
    getFollowers();
    getFollowing();
    checkIfFollow();
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

  void getFollowers() async {
    QuerySnapshot snapshot = await followerRef
        .document(widget.profileId)
        .collection('userFollowers')
        .getDocuments();
    setState(() {
      followerCount = snapshot.documents.length;
    });
  }

  void getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(widget.profileId)
        .collection('userFollowing')
        .getDocuments();
    setState(() {
      followingCount = snapshot.documents.length;
    });
  }

  void checkIfFollow() async {
    DocumentSnapshot doc = await followerRef
        .document(widget.profileId)
        .collection('userFollowers')
        .document(currentUserId)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  Widget buildProfileHeader() {
    return FutureBuilder(
      future: usersRef.document(widget.profileId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'userProfile',
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 2),
                  child: Text(
                    user.displayName,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(user.username,
                      style: Theme.of(context).textTheme.display3),
                ),
                user.bio.isEmpty
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(user.bio,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13)),
                      ),
                buildProfileButton(),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildCount("Follower", followerCount),
                      buildCount("Following", followingCount),
                    ],
                  ),
                ),
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

  void handleUnfollow() {
    setState(() {
      isFollowing = false;
    });
    followerRef
        .document(widget.profileId)
        .collection('userFollowers')
        .document(currentUserId)
        .get()
        .then((doc) {
      doc.reference.delete();
    });
    followingRef
        .document(currentUserId)
        .collection('userFollowing')
        .document(widget.profileId)
        .get()
        .then((doc) {
      doc.reference.delete();
    });
    feedRef
        .document(widget.profileId)
        .collection('feedItems')
        .document(currentUserId)
        .get()
        .then((doc) {
      doc.reference.delete();
    });
  }

  void handleFollow() {
    setState(() {
      isFollowing = true;
    });
    followerRef
        .document(widget.profileId)
        .collection('userFollowers')
        .document(currentUserId)
        .setData({});
    followingRef
        .document(currentUserId)
        .collection('userFollowing')
        .document(widget.profileId)
        .setData({});
    feedRef
        .document(widget.profileId)
        .collection('feedItems')
        .document(currentUserId)
        .setData({
      'type': 'follow',
      'ownerId': widget.profileId,
      'username': currentUser.username,
      'userId': currentUserId,
      'userUrl': currentUser.photoUrl,
      'timestamp': timeStamp
    });
  }

  Widget buildProfileButton() {
    bool isProfileOwn = currentUserId == widget.profileId;
    if (isProfileOwn) {
      return buildButton(text: "Edit Profile", function: editProfile);
    } else if (isFollowing) {
      return buildButton(text: "Unfollow", function: handleUnfollow);
    } else if (!isFollowing) {
      return buildButton(text: "Follow", function: handleFollow);
    }
    return Text("Profile Button");
  }

  Container buildButton({String text, Function function}) {
    return Container(
        width: 130,
        height: 27,
        child: FlatButton(
          onPressed: function,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 13,
                  color: isFollowing ? Colors.black : Colors.white),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isFollowing ? Colors.grey : Colors.green[600]),
                color: isFollowing ? Colors.transparent : Colors.green[600],
                borderRadius: BorderRadius.circular(15)),
          ),
        ));
  }

  //used for building followers counter etc.
  Widget buildCount(String label, int count) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(label, style: Theme.of(context).textTheme.display3),
          ),
          SizedBox(
            width: 80,
          ),
          Text(count.toString()),
        ],
      ),
    );
  }

  Widget buildCollection() {
    return Center(
      child: Text("Collection Feature Coming Soon..."),
    );
  }

  Widget buildPosts() {
    if (isLoading) {
      return circularProgress(context);
    } else if (posts.isEmpty) {
      return Center(
        child: Text("Nothing to show here..."),
      );
    }
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(3),
      crossAxisCount: 4,
      itemCount: postCount,
      itemBuilder: (_, i) => Post(
          userPhoto: posts[i].userPhoto,
          displayName: posts[i].displayName,
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
    );
  }

  Widget buildToggle() {
    return Container(
      child: TabBar(
        unselectedLabelColor: Colors.grey,
        labelColor: Theme.of(context).primaryColor,
        controller: _tabController,
        indicatorColor: Theme.of(context).primaryColor,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.photo_size_select_actual),
          ),
          Tab(
            icon: Icon(Icons.collections),
          )
        ],
      ),
    );
  }

  void buildNotification() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ActivityFeed()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: false,
                pinned: false,
                title: Text("Profile"),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: buildNotification)
                ],
              ),
              new SliverList(
                  delegate: new SliverChildListDelegate([
                buildProfileHeader(),
                Divider(),
                buildToggle(),
                Divider(),
              ])),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              buildPosts(),
              buildCollection(),
            ],
          ),
        ),
      ),
    );
  }
}
