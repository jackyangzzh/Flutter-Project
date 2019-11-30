import 'package:flutter/material.dart';
import '../Widgets/item_grid.dart';

class CollectOverviewScreen extends StatelessWidget {
  final String routeName = '/collect-overview';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    var scaffold = Scaffold(
      appBar: AppBar(title: Text('Collections')),
      body: ItemGrid(), 
    );
    return scaffold;
  }
}


