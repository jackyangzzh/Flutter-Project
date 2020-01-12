import 'package:collection_app/Screens/edit_collection_screen.dart';
import './Providers/profolio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Screens/collect_overview_screen.dart';
import './Screens/item_detail_screen.dart';
import './Providers/product_provider.dart';
import './Screens/profolio_screen.dart';
import './Providers/history.dart';
import './Screens/past_collection_screen.dart';
import './Screens/user_collection_screen.dart';
import './Screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(
          value: Profolio(),
        ),
        ChangeNotifierProvider.value(
          value: History(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Collection App',
        theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            accentColor: Colors.yellowAccent,
            canvasColor: Colors.lightGreen[50],
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(fontSize: 15, color: Colors.black),
                body2: TextStyle(color: Colors.black),
                title: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                ),
                subtitle: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                  color: Colors.grey,
                ),
                display1: TextStyle(fontSize: 15, fontFamily: 'Monteserrat'),
                caption: TextStyle(fontSize: 13))),
        home: AuthScreen(),
        routes: {
          ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(),
          ProfolioCart.routeName: (ctx) => ProfolioCart(),
          PastCollectionScreen.routeName: (ctx) => PastCollectionScreen(),
          UserCollectionScreen.routeName: (ctx) => UserCollectionScreen(),
          EditCollectionScreen.routeName: (ctx) => EditCollectionScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('collect'),
      ),
      body: Center(
        child: Text('Let\'s build a collection!'),
      ),
    );
  }
}
