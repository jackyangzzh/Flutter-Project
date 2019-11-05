import './Widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './Widgets/user_transaction.dart';
import './Models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction();
    },);
  }

  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'Shoes', amount: 120, date: DateTime.now()),
    Transaction(id: 't2', title: 'Hoodie', amount: 79.99, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Me!',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Finance Me!'),
      ),
      body: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text('Chart'),
                elevation: 3,
              ),
            ),
            UserTransaction(),
          ],
        ),
      ),
    );
  }
}
