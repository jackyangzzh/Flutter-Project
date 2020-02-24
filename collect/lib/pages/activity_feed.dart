import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:collect/pages/home.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    List<ActivityFeedItem> feedItem = [];
    snapshot.documents.forEach((doc) {
      feedItem.add(ActivityFeedItem.fromDocument(doc));
    });
    return feedItem;
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

              return ListView(
                children: snapshot.data,
              );
            }),
      ),
    );
  }
}

class ActivityFeedItem extends StatelessWidget {
  final String username;
  final String userId;
  final String type;
  final String mediaUrl;
  final String postId;
  final String userUrl;
  final String comment;
  final Timestamp timestamp;

  Widget mediaPreview;
  Text feedText;

  ActivityFeedItem({
    this.username,
    this.userId,
    this.type,
    this.mediaUrl,
    this.postId,
    this.userUrl,
    this.comment,
    this.timestamp,
  });

  factory ActivityFeedItem.fromDocument(DocumentSnapshot doc) {
    return ActivityFeedItem(
      username: doc['username'],
      userId: doc['userId'],
      type: doc['type'],
      mediaUrl: doc['mediaUrl'],
      postId: doc['postId'],
      userUrl: doc['userUrl'],
      comment: doc['commentData'],
      timestamp: doc['timestamp'],
    );
  }

  void buildMediaPreview() {
    if (type == 'like' || type == comment) {
      mediaPreview = GestureDetector(
        onTap: () => print("post"),
        child: Container(
            height: 50,
            width: 50,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(mediaUrl),
              ))),
            )),
      );
    } else {
      mediaPreview = Text("Follow");
    }

    if (type == "like") {
      feedText = Text("liked");
    } else if (type == "follow") {
      feedText = Text("Followed");
    } else if (type == "comment") {
      feedText = Text("said: $comment");
    } else {
      feedText = Text("Unknown type $type");
    }
  }

  @override
  Widget build(BuildContext context) {
    buildMediaPreview();

    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Container(
        color: Colors.white54,
        child: ListTile(
          title: GestureDetector(
            onTap: () => print("Show profioe"),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text: username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '$feedText')
                  ]),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userUrl),
          ),
          subtitle: Text(
            timeago.format(timestamp.toDate()),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: mediaPreview,
        ),
      ),
    );
  }
}
