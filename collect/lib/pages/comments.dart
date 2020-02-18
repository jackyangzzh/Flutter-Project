import 'package:collect/pages/home.dart';
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
  TextEditingController commentController = TextEditingController();

  CommentsState({this.postId, this.ownerId, this.mediaUrl});

  Widget buildComment() {
    return Text("comment");
  }

  void addComment() {
    commentRef.document(postId).collection("comments").add({
      "username": currentUser.username,
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
  @override
  Widget build(BuildContext context) {
    return Text("comment");
  }
}
