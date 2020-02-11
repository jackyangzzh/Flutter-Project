import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/pages/post_detail.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String caption;
  final String description;
  final String mediaUrl;
  final dynamic likes;

  Post(
      {this.postId,
      this.ownerId,
      this.username,
      this.location,
      this.caption,
      this.description,
      this.mediaUrl,
      this.likes});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      location: doc['location'],
      caption: doc['caption'],
      description: doc['description'],
      mediaUrl: doc['mediaUrl'],
      likes: doc['likes'],
    );
  }

  int getLikeCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count++;
      }
    });
  }

  @override
  _PostState createState() => _PostState(
      postId: this.postId,
      ownerId: this.ownerId,
      username: this.username,
      location: this.location,
      caption: this.caption,
      description: this.description,
      mediaUrl: this.mediaUrl,
      likes: this.likes,
      likeCount: this.getLikeCount(this.likes));
}

class _PostState extends State<Post> {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String caption;
  final String description;
  final String mediaUrl;
  int likeCount;
  Map likes;

  _PostState(
      {this.postId,
      this.ownerId,
      this.username,
      this.location,
      this.caption,
      this.description,
      this.mediaUrl,
      this.likes,
      this.likeCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostDetail()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage(
              placeholder: AssetImage('assets/images/placeholder.png'),
              image: NetworkImage(mediaUrl),
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child:
                    Text(caption, style: Theme.of(context).textTheme.headline)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    iconSize: 17,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.comment),
                    iconSize: 17,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
