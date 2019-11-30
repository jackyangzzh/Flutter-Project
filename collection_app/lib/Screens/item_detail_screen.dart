import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-detail';
  final String imageUrl;
  final String title;
  final String description;

  ItemDetailScreen(this.imageUrl, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

    );
  }
}
