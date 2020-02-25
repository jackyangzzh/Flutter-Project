import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/models/user.dart';
import 'package:collect/pages/profile.dart';
import 'package:collect/pages/timeline.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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

  AppBar buildSearchField() {
    return AppBar(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: searchResults == null ? Container() : buildSearchResult(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult(this.user);

  void showProfile(BuildContext context, {String userId}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Profile(profileId: userId)));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Container(
    //   color: Colors.green,
    //   child: Column(
    //     children: <Widget>[
    //       GestureDetector(
    //         // onTap: () => showProfile(context, userId: user.id),
    //         onTap: () => print("Tapped"),
    //         child: ListTile(
    //           leading: CircleAvatar(
    //             radius: 25,
    //             backgroundImage: CachedNetworkImageProvider(user.photoUrl),
    //           ),
    //           title: Text(user.displayName,
    //               style: TextStyle(
    //                   color: Colors.black, fontWeight: FontWeight.bold)),
    //           subtitle:
    //               Text(user.username, style: TextStyle(color: Colors.black)),
    //         ),
    //       ),
    //       Divider()
    //     ],
    //   ),
    // );
  }
}
