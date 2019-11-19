import 'package:flutter/material.dart';
import 'dart:math';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transactions,
    @required Function deleteTransaction,
  })  : _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction transactions;
  final Function _deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
          padding: EdgeInsets.all(10),
          child: Text(
            '\$ ${widget.transactions.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 24,
            ),
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.transactions.title,
                style: Theme.of(context).textTheme.title,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                DateFormat.yMMMEd().format(widget.transactions.date),
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget._deleteTransaction(widget.transactions.id),
        ),
      ],
    ));
  }
}
