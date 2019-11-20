import 'package:flutter/material.dart';


class CategoryItem extends StatelessWidget {
  final String _title;
  final Color _color;

  CategoryItem(this._title, this._color);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Text(_title, style: Theme.of(context).textTheme.title,),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            _color.withOpacity(0.6),
            _color,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(10),
        ));
  }
}
