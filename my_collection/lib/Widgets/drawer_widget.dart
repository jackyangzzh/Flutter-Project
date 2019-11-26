import 'package:flutter/material.dart';
import '../Screens/category_screen.dart';
import '../Screens/setting_screen.dart';
import '../Screens/filter_screen.dart';

class DrawerWidget extends StatelessWidget {
  Widget drawerBuilder(IconData icon, String text, Function func) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        '$text',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      onTap: func,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'COLLECT',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 21),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          drawerBuilder(Icons.filter, 'Gallery', () {
            Navigator.of(context).pushNamed('/');
          }),
          drawerBuilder(Icons.filter_list, 'Filter', () {
            Navigator.of(context).pushNamed(FilterScreen.routeName);
          }),
          drawerBuilder(Icons.settings, 'Setting', () {
            Navigator.of(context).pushNamed(SettingScreen.routeName);
          })
        ],
      ),
    );
  }
}
