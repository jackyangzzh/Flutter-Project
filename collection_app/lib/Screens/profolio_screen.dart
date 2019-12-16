import 'package:flutter/material.dart';
import '../Providers/profolio.dart' show Profolio;
import 'package:provider/provider.dart';
import '../Widgets/profolio_item.dart';

class ProfolioCart extends StatelessWidget {
  static const routeName = "/profolio";

  @override
  Widget build(BuildContext context) {
    final profolio = Provider.of<Profolio>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profolio Screen'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Total Challenges: ${profolio.profolioSize}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  FlatButton(
                    child: Text(
                      "START CHALLENGE",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: profolio.profolioSize,
              itemBuilder: (ctx, i) => ProfolioItem(
                  profolio.items.values.toList()[i].id,
                  profolio.items.keys.toList()[i],
                  profolio.items.values.toList()[i].title,
                  profolio.items.values.toList()[i].imageUrl),
            ),
          )
        ],
      ),
    );
  }
}
