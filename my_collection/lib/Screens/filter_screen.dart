import 'package:flutter/material.dart';
import '../Widgets/drawer_widget.dart';

class FilterScreen extends StatelessWidget {
  static const String routeName = '/filter_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
    );
  }
}
