import 'package:collection_app/Widgets/app_drawer.dart';

import '../Providers/profolio.dart';
import 'package:flutter/material.dart';
import '../Widgets/item_grid.dart';
import '../Widgets/badge.dart';
import 'package:provider/provider.dart';
import '../Screens/profolio_screen.dart';

enum FilterOption {
  Favoriate,
  All,
}

class CollectOverviewScreen extends StatefulWidget {
  @override
  _CollectOverviewScreenState createState() => _CollectOverviewScreenState();
}

class _CollectOverviewScreenState extends State<CollectOverviewScreen> {
  final String routeName = '/collect-overview';
  bool _showFavoriate = false;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Collections'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.Favoriate) {
                    _showFavoriate = true;
                  } else {
                    _showFavoriate = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favoriate'),
                      value: FilterOption.Favoriate,
                    ),
                    PopupMenuItem(
                      child: Text('Show all'),
                      value: FilterOption.All,
                    )
                  ]),
          Consumer<Profolio>(
            builder: (_, profolio, ch) => Badge(
              child: ch,
              value: profolio.profolioSize.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.photo_album),
              onPressed: () {
                Navigator.of(context).pushNamed(ProfolioCart.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ItemGrid(_showFavoriate),
    );
    return scaffold;
  }
}
