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
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  getUsers() async {
    QuerySnapshot snap = await usersRef
        .orderBy('postCount' ,descending: true)
        .getDocuments();
    snap.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isTitle: true),
      body: Text('Timeline'),
    );
  }
}
