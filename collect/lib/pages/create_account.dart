import 'package:collect/widgets/header.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  final _formKey = GlobalKey<FormState>();

  void submit() {
    _formKey.currentState.save();
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: header(context, isTitle: false, titleText: 'Welcome'),
      body: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: Text("What would be your username?",
                      style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        onSaved: (input) => username = input,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: GestureDetector(
                    onTap: submit,
                    child: Container(
                      height: 40,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
