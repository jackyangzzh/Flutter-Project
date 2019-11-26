import 'package:flutter/material.dart';
import '../Widgets/drawer_widget.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting'), centerTitle: true,),
      drawer: DrawerWidget(),
      body: Center(
        child: Text('Unforunately, this setting page is not set yet'),
      ),
    );
  }
}
