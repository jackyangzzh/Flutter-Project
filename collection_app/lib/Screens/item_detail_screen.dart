import '../Providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-detail';

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context).settings.arguments as String;
    final item =
        Provider.of<ProductProvider>(context, listen: false).findById(itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
       body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 20, bottom: 15, left: 8, right: 8),
                child: Text(
                  '${(item.title)}',
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
                     item.location == null ? 
                    'Mystery' : '${item.location}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                child: Text(
                  '${item.description}',
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
    );
  }
}
