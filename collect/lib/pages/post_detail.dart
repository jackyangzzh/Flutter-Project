import 'dart:async';
import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collect/pages/comments.dart';
import 'package:collect/pages/home.dart';
import 'package:collect/widgets/custom_image.dart';
import 'package:collect/widgets/post.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatefulWidget {
  final String postId;
  final String ownerId;

  PostDetail({this.postId, this.ownerId});

  @override
  _PostDetailState createState() =>
      _PostDetailState(postId: this.postId, ownerId: this.ownerId);
}

class _PostDetailState extends State<PostDetail> {
  final String postId;
  final String ownerId;
  final String currentUserId = currentUser?.id;
  Map likes;
  bool isLiked;
  int likeCount;
  bool showHeart = false;

  Post post;

  _PostDetailState({this.postId, this.ownerId});

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

  void likePost() {
    bool _isLiked = likes[currentUserId] == true;

    if (_isLiked) {
      postRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.$currentUserId': false});
      setState(() {
        likeCount--;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else {
      postRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.$currentUserId': true});
      setState(() {
        likeCount++;
        isLiked = true;
        likes[currentUserId] = true;
        showHeart = true;
      });
    }

    Timer(Duration(milliseconds: 500), () {
      setState(() {
        showHeart = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        post = Post.fromDocument(snapshot.data);
        likes = post.likes;
        likeCount = getLikeCount(likes);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: GestureDetector(
              onTap: () => print("tapped"),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(post.userPhoto),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(post.displayName,
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                      Text(post.username,
                          style: TextStyle(color: Colors.black54, fontSize: 13))
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onDoubleTap: likePost,
                  child: Hero(
                    tag: postId,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        cachedNetworkImage(post.mediaUrl),
                        showHeart
                            ? Animator(
                                duration: Duration(milliseconds: 300),
                                tween: Tween(begin: 0.8, end: 1.8),
                                curve: Curves.easeInOut,
                                cycles: 0,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: Icon(
                                    Icons.favorite,
                                    size: 50,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              top: 20, bottom: 10, left: 8, right: 8),
                          child: Text(
                            '${post.caption}',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                          child: Row(children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 17,
                            ),
                            Text(
                              post.location == null ? '' : '${post.location}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: likePost,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(children: <Widget>[
                                Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 23,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${post.getLikeCount(post.likes)}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  child: Text(
                    post.description == null ? '' : '${post.description}',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Text(
                    DateFormat.yMMMEd().format(post.timestamp.toDate()),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Container(
                  child: Comment(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
