import 'package:flutter/material.dart';
import '../Widgets/drawer_widget.dart';

class FilterScreen extends StatefulWidget {
  static const String routeName = '/filter_screen';
  final Function applyFilter;

  FilterScreen(this.applyFilter);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _wouldRecommend = false;
  bool _wouldAgain = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: widget.applyFilter,
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your filter here',
                style: Theme.of(context).textTheme.title),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Would Recommend'),
                  value: _wouldRecommend,
                  onChanged: (b) {
                    setState(() {
                      _wouldRecommend = b;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Would Do it Again'),
                  value: _wouldAgain,
                  onChanged: (b) {
                    setState(() {
                      _wouldAgain = b;
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
