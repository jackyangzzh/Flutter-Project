import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/pages/home.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String mediaUrl;

  Comments({this.postId, this.ownerId, this.mediaUrl});

  @override
  CommentsState createState() => CommentsState(
      postId: this.postId, ownerId: this.ownerId, mediaUrl: this.mediaUrl);
}

class CommentsState extends State<Comments> {
  final String postId;
  final String ownerId;
  final String mediaUrl;
  TextEditingController commentController = TextEditingController();

  CommentsState({this.postId, this.ownerId, this.mediaUrl});

  Widget buildComment() {
    return StreamBuilder(
      stream: commentRef
          .document(postId)
          .collection('comments')
          .orderBy("timestamp", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        List<Comment> comments = [];
        snapshot.data.documents.forEach((doc) {
          comments.add(Comment.fromDocument(doc));
        });
        return Column(
          children: comments,
        );
      },
    );
  }

  void addComment() {
    commentRef.document(postId).collection("comments").add({
      "username": currentUser.username,
      "displayName": currentUser.displayName,
      "comment": commentController.text,
      "timestamp": timeStamp,
      "userUrl": currentUser.photoUrl,
      "userId": currentUser.id
    });
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Comment")),
        body: Column(
          children: <Widget>[
            Expanded(child: buildComment()),
            Divider(),
            ListTile(
              title: TextFormField(
                controller: commentController,
                decoration: InputDecoration(hintText: "Comment here..."),
              ),
              trailing:
                  IconButton(icon: Icon(Icons.send), onPressed: addComment),
            )
          ],
        ));
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String displayName;
  final String userId;
  final String userUrl;
  final String comment;
  final Timestamp timestamp;

  Comment(
      {this.username,
      this.displayName,
      this.userId,
      this.userUrl,
      this.comment,
      this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc["username"],
      displayName: doc["displayName"],
      userId: doc["userId"],
      userUrl: doc["userUrl"],
      comment: doc["comment"],
      timestamp: doc["timestamp"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.87,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(userUrl),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              displayName,
                              style: Theme.of(context).textTheme.display4,
                            ),
                            Text(
                              timeago.format(timestamp.toDate()),
                              style: Theme.of(context).textTheme.display3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          comment,
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
