import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/pages/post_detail.dart';
import 'package:collect/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String userPhoto;
  final String displayName;
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String caption;
  final String description;
  final String mediaUrl;
  final Timestamp timestamp;
  final dynamic likes;

  Post(
      {this.userPhoto,
      this.displayName,
      this.postId,
      this.ownerId,
      this.username,
      this.location,
      this.caption,
      this.description,
      this.timestamp,
      this.mediaUrl,
      this.likes});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      userPhoto: doc['userPhoto'],
      displayName: doc['displayName'],
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      location: doc['location'],
      caption: doc['caption'],
      description: doc['description'],
      timestamp: doc['timestamp'],
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
    return count;
  }

  @override
  _PostState createState() => _PostState(
      userPhoto: this.userPhoto,
      displayName: this.displayName,
      postId: this.postId,
      ownerId: this.ownerId,
      username: this.username,
      location: this.location,
      caption: this.caption,
      description: this.description,
      mediaUrl: this.mediaUrl,
      timestamp: this.timestamp,
      likes: this.likes,
      likeCount: this.getLikeCount(this.likes));
}

class _PostState extends State<Post> {
  final String userPhoto;
  final String displayName;
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String caption;
  final Timestamp timestamp;
  final String description;
  final String mediaUrl;
  int likeCount;
  Map likes;

  _PostState(
      {this.userPhoto,
      this.displayName,
      this.postId,
      this.ownerId,
      this.username,
      this.location,
      this.caption,
      this.timestamp,
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PostDetail(widget)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'userImage',
              child: cachedNetworkImage(mediaUrl),
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
                  GestureDetector(
                    onTap: () {},
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('$likeCount')
                    ]),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.comment,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("")
                    ]),
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
