import 'package:flutter/material.dart';
import '../Screens/past_collection_screen.dart';
import '../Screens/user_collection_screen.dart';
import '../Providers/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("Browse"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PastCollectionScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.mode_edit),
            title: Text('Your Collection'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserCollectionScreen.routeName);
            },
          ),
          ListTile(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
