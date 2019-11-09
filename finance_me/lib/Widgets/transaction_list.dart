import '../Models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  SizedBox(height: 100,),
                  Container(
                      height: 170,
                      child: Image.asset(
                    'assets/images/nothing.png',
                    fit: BoxFit.cover,
                  )),
                  Text(
                    'Add something please',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                padding: EdgeInsets.all(10),
                child: Text(
                  '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24,),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style:
                          Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey[700]),
                    )
                  ],
                ),
              ),
            ],
          ));
        },
        itemCount: transactions.length,
      ),
    );
  }
}
