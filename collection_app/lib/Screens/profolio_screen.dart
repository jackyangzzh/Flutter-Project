import 'package:flutter/material.dart';
import '../Providers/profolio.dart' show Profolio;
import 'package:provider/provider.dart';
import '../Widgets/profolio_item.dart';
import '../Providers/history.dart';

class ProfolioCart extends StatelessWidget {
  static const routeName = "/profolio";

  @override
  Widget build(BuildContext context) {
    final profolio = Provider.of<Profolio>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profolio'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Total Challenges: ${profolio.profolioSize}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  UploadButton(profolio: profolio),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: profolio.profolioSize,
              itemBuilder: (ctx, i) => ProfolioItem(
                  profolio.items.values.toList()[i].id,
                  profolio.items.keys.toList()[i],
                  profolio.items.values.toList()[i].title,
                  profolio.items.values.toList()[i].imageUrl),
            ),
          )
        ],
      ),
    );
  }
}

class UploadButton extends StatefulWidget {
  const UploadButton({
    Key key,
    @required this.profolio,
  }) : super(key: key);

  final Profolio profolio;

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(Icons.cloud_upload),
      label: Text(
        "UPLOAD",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onPressed: (widget.profolio.profolioSize <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<History>(context, listen: false).addHistory(
                  widget.profolio.items.values.toList(),
                  widget.profolio.profolioSize);
              setState(() {
                _isLoading = false;
              });
              widget.profolio.clearProfolio();
            },
    );
  }
}
