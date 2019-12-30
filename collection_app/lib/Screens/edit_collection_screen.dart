import 'package:flutter/material.dart';

class EditCollectionScreen extends StatefulWidget {
  static const routeName = '/editCollection';

  @override
  _EditCollectionScreenState createState() => _EditCollectionScreenState();
}

class _EditCollectionScreenState extends State<EditCollectionScreen> {
  final _locationFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_locationFocus);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                textInputAction: TextInputAction.next,
                focusNode: _locationFocus,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
