import 'package:collect/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatelessWidget {
  final Post post;

  PostDetail(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.username),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Image.network(
                post.mediaUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20, bottom: 15, left: 8, right: 8),
              child: Text(
                '${post.caption}',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Row(children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                Text(
                  post.location == null ? '' : '${post.location}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ]),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
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
          ],
        ),
      ),
    );
  }
}
