import 'transaction_item.dart';
import 'package:flutter/rendering.dart';

import '../Models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  const TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, contraints) {
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      height: contraints.maxHeight * 0.4,
                      child: Image.asset(
                        'assets/images/nothing.png',
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add something please',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                    key: ValueKey(tx.id),
                    transactions: tx,
                    deleteTransaction: _deleteTransaction))
                .toList(),
          );
  }
}
