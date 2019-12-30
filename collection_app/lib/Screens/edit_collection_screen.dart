import 'package:flutter/material.dart';

class EditCollectionScreen extends StatefulWidget {
  @override
  _EditCollectionScreenState createState() => _EditCollectionScreenState();
}

class _EditCollectionScreenState extends State<EditCollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing"),
      ),
    );
  }
}
