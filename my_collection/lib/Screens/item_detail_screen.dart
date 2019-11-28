import 'package:flutter/material.dart';
import '../dummy_data.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-detail';
  final Function loadFavoriate;
  final Function isFavoriate;

  ItemDetailScreen(this.isFavoriate, this.loadFavoriate);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final _itemId = routeArgs['id'];
    final _selectedItem =
        dummyCollection.firstWhere((item) => item.id == _itemId);

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Navigator.of(context).pop(_itemId);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Image.network(
                  _selectedItem.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 25, bottom: 15, left: 8, right: 8),
                child: Text(
                  '${_selectedItem.title}',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                child: Row(children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  Text(
                    '${_selectedItem.location}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                child: Text(
                  '${_selectedItem.description}',
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Text(
                  DateFormat.yMMMEd().format(new DateTime.now()),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(isFavoriate(_itemId)? Icons.favorite : Icons.favorite_border),
          onPressed: () => loadFavoriate(_itemId),
        ));
  }
}
