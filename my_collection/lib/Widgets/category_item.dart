import 'package:flutter/material.dart';
import '../Screens/category_collect_screen.dart';

class CategoryItem extends StatelessWidget {
  final String _id;
  final String _title;
  final Color _color;

  CategoryItem(this._id, this._title, this._color);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryCollectScreen.routeName,
        arguments: {'id': _id, 'title': _title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Text(
            _title,
            style: Theme.of(context).textTheme.title,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              _color.withOpacity(0.6),
              _color,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
