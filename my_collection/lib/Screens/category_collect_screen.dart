import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../Widgets/collect_item.dart';
import '../Model/collection.dart';

class CategoryCollectScreen extends StatefulWidget {
  static const routeName = '/collection_page';

  @override
  _CategoryCollectScreenState createState() => _CategoryCollectScreenState();
}

class _CategoryCollectScreenState extends State<CategoryCollectScreen> {
  String _categoryTitle;
  List<Collection> displayedItem;
  bool _loadData = false;

  @override
  void didChangeDependencies() {
    if(!_loadData){
      final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _categoryTitle = routeArgs['title'];
    final _categoryID = routeArgs['id'];
    displayedItem = dummyCollection.where((item) {
      return item.categories.contains(_categoryID);
    }).toList();
    }
    _loadData = true;

    super.didChangeDependencies();
  }

  void _removeItem(String id) {
    setState(() {
      displayedItem.removeWhere((item) {
        return item.id.contains(id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return CollectItem(
            id: displayedItem[i].id,
            title: displayedItem[i].title,
            imageUrl: displayedItem[i].imageUrl,
            location: displayedItem[i].location,
            mood: displayedItem[i].mood,
            difficulty: displayedItem[i].difficulty,
            remove: _removeItem,
          );
        },
        itemCount: displayedItem.length,
      ),
    );
  }
}
