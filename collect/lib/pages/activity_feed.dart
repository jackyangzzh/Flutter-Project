import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:collect/pages/home.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  Future getFeed() async {
    QuerySnapshot snapshot = await feedRef
        .document(currentUser.id)
        .collection('feedItem')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .getDocuments();
    return snapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification")),
      body: Container(
        child: FutureBuilder(
            future: getFeed(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return circularProgress(context);
              }
              return Text("activity");
            }),
      ),
    );
  }
}

class ActivityFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}
