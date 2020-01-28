import 'package:collect/widgets/header.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isTitle: true),
      body: FutureBuilder<QuerySnapshot>(
        future: usersRef.getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress(context);
          }
          final List<Text> userList = snapshot.data.documents
              .map((user) => Text(user['username']))
              .toList();
          return Container(
            child: ListView(
              children: userList,
            ),
          );
        },
      ),
    );
  }
}
