import 'package:flutter/material.dart';
import '../Widgets/item_grid.dart';

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
        ],
      ),
      body: ItemGrid(_showFavoriate),
    );
    return scaffold;
  }
}
