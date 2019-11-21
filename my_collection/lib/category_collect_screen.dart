import 'package:flutter/material.dart';

class CategoryCollectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Collection Page'),
      ),
      body: Container(child: Text('Welcome to the collection page'),),
    );
  }
}
