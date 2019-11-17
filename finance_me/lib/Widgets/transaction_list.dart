import 'package:flutter/rendering.dart';

import '../Models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, contraints){
            return Column(
              children: <Widget>[
                SizedBox(
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
          },) 
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$ ${transactions[index].amount.toStringAsFixed(2)}',
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
                            transactions[index].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            DateFormat.yMMMEd()
                                .format(transactions[index].date),
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => _deleteTransaction(transactions[index].id),
                    ),
                  ],
                ));
              },
              itemCount: transactions.length,
    );
  }
}
