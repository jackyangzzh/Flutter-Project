import 'package:flutter/material.dart';
import '../Providers/history.dart';
import 'package:provider/provider.dart';

class PastCollectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pastCollection = Provider.of<History>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Collections"),
      ),
      body: ListView.builder(
        itemCount: pastCollection.getHistory.length,
      ),
    );
  }
}
