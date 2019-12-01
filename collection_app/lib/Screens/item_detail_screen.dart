import '../Providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    final itemId = ModalRoute.of(context).settings.arguments as String;
    final item = Provider.of<ProductProvider>(context, listen: false).findById(itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      
    );
  }
}
