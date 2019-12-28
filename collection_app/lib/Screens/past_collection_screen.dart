import 'package:flutter/material.dart';
import '../Providers/history.dart';
import 'package:provider/provider.dart';
import '../Widgets/past_collection.dart';
import '../Widgets/app_drawer.dart';

class PastCollectionScreen extends StatelessWidget {
  static const routeName = './pastCollection';

  @override
  Widget build(BuildContext context) {
    final pastCollection = Provider.of<History>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Collections"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: pastCollection.getHistory.length,
          itemBuilder: (ctx, i) =>
              PastCollection(pastCollection.getHistory[i])),
    );
  }
}
