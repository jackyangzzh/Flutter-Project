import 'package:collect/widgets/header.dart';
import 'package:flutter/material.dart';

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

  CommentsState({this.postId, this.ownerId, this.mediaUrl});

  Widget buildComment() {
    return Text("comment");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, titleText: "Comment"),
        body: Column(
          children: <Widget>[
            buildComment(),
          ],
        ));
  }
}

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("comment");
  }
}
