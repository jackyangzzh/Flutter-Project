import 'package:flutter/material.dart';
import './Widgets/collect_item.dart';
import './Screens/filter_screen.dart';
import './Screens/setting_screen.dart';
import './Screens/item_detail_screen.dart';
import './Screens/category_collect_screen.dart';
import './Screens/category_screen.dart';
import './Screens/tab_screen.dart';
import './dummy_data.dart';
import './Model/collection.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'wouldRecommend': false,
    'wouldAgain': false,
  };

  List<Collection> _avaiableItem = dummyCollection;
  List<Collection> _favoriateItem = [];

  bool _isFavoriate(String mealId){
    return _favoriateItem.any((item)=>item.id == mealId);
  }

  void _setFilter(Map<String, bool> filter) {
    setState(() {
      _filter = filter;

      _avaiableItem = dummyCollection.where((item) {
        if (_filter['wouldRecommend'] && !item.wouldRecommand) {
          return false;
        }
        if (_filter['wouldAgain'] && !item.wouldAgain) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _loadFavoriate(String itemId) {
    final existingId = _favoriateItem.indexWhere((item) => item.id == itemId);
    if (existingId >= 0) {
      setState(() {
        _favoriateItem.removeAt(existingId);
      });
    } else {
      setState(() {
        _favoriateItem
            .add(dummyCollection.firstWhere((item) => item.id == itemId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Collection App',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.yellow,
          canvasColor: Color.fromRGBO(235, 255, 255, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(fontSize: 15, color: Colors.black),
              body2: TextStyle(color: Colors.black),
              title: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600),
              caption: TextStyle(fontSize: 13))),
      // home: TabScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favoriateItem),
        CategoryCollectScreen.routeName: (ctx) =>
            CategoryCollectScreen(_avaiableItem),
        ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(_isFavoriate, _loadFavoriate),
        FilterScreen.routeName: (ctx) => FilterScreen(_filter, _setFilter),
        SettingScreen.routeName: (ctx) => SettingScreen(),
      },
      //Fall back screen if error
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (ctx) => CategoryScreen());
      },
    );
  }
}
