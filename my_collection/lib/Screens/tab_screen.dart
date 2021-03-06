import 'package:flutter/material.dart';
import '../Model/collection.dart';
import './favoriate_screen.dart';
import './category_screen.dart';
import '../Widgets/drawer_widget.dart';

class TabScreen extends StatefulWidget {
  final List<Collection> favoriateItem;

  TabScreen(this.favoriateItem);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    _screens  = [
      {
        'page': CategoryScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriateScreen(widget.favoriateItem),
        'title': 'Favorites',
      }
    ];

    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedPageIndex]['title']),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: _screens[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text('Category')),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              title: Text('Favoriates')),
        ],
      ),
    );
  }
}
