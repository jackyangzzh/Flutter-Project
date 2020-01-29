import 'package:collect/widgets/header.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: header(context, isTitle: false, titleText: 'Welcome'),
      body: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text("What would be your username?",
                      style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Container(
                    child: Form(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
