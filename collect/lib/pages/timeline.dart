import 'package:cached_network_image/cached_network_image.dart';
import 'package:collect/models/user.dart';
import 'package:collect/widgets/header.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
  }

  Future<QuerySnapshot> searchResults;
  TextEditingController searchController = TextEditingController();

  void searchHandler(String keyword) {
    Future<QuerySnapshot> users = usersRef
        .where('displayName', isGreaterThanOrEqualTo: keyword)
        .getDocuments();

    setState(() {
      searchResults = users;
    });
  }

  void clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => searchController.clear());
    setState(() {
      searchResults = null;
    });
  }

  Widget buildSearchResult() {
    return FutureBuilder(
      future: searchResults,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        List<UserResult> searchResultList = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          UserResult userResult = UserResult(user);
          searchResultList.add(userResult);
        });
        if (searchResultList.length == 0) {
          return Text("Nothing was found");
        }
        return ListView(children: searchResultList);
      },
    );
  }

  SliverAppBar buildSearchField() {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: "Search here...",
          filled: true,
          prefixIcon: Icon(
            Icons.search,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: searchHandler,
      ),
    );
  }

  Widget buildTimeline() {
    return StreamBuilder<QuerySnapshot>(
      stream: usersRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        final List<Text> userList = snapshot.data.documents
            .map((user) => Text(user['username']))
            .toList();
        return Container(
          child: ListView(
            children: userList,
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScolled) {
        return <Widget>[buildSearchField()];
      },
      body: searchResults == null ? buildTimeline() : buildSearchResult(),
    ));
    //  searchResults == null ? buildTimeline() : buildSearchResult(),
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: CircleAvatar(
                radius: 27,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(user.displayName,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              subtitle:
                  Text(user.username, style: TextStyle(color: Colors.black)),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
