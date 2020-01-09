import 'package:flutter/material.dart';
import '../Providers/history.dart';
import 'package:provider/provider.dart';
import '../Widgets/past_collection.dart';
import '../Widgets/app_drawer.dart';

class PastCollectionScreen extends StatefulWidget {
  static const routeName = './pastCollection';

  @override
  _PastCollectionScreenState createState() => _PastCollectionScreenState();
}

class _PastCollectionScreenState extends State<PastCollectionScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<History>(context, listen: false).fetchData();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pastCollection = Provider.of<History>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Collections"),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : ListView.builder(
              itemCount: pastCollection.getHistory.length,
              itemBuilder: (ctx, i) =>
                  PastCollection(pastCollection.getHistory[i])),
    );
  }
}
