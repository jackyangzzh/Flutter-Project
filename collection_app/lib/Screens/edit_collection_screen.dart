import 'package:collection_app/Widgets/collection_item.dart';
import 'package:flutter/material.dart';
import '../Providers/collection.dart';

class EditCollectionScreen extends StatefulWidget {
  static const routeName = '/editCollection';

  @override
  _EditCollectionScreenState createState() => _EditCollectionScreenState();
}

class _EditCollectionScreenState extends State<EditCollectionScreen> {
  final _locationFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editCollection =
      new Collection(id: null, title: '', description: '', imageUrl: '');

  @override
  void initState() {
    _imageFocus.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageFocus.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageFocus.removeListener(_updateImageUrl);
    _locationFocus.dispose();
    _descriptionFocus.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _saveForm() {
    _form.currentState.save();
    print(_editCollection.title);
    print(_editCollection.description);
    print(_editCollection.imageUrl);
    print(_editCollection.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_locationFocus);
                },
                onSaved: (_value) {
                  _editCollection = Collection(
                      id: _editCollection.id,
                      title: _value,
                      description: _editCollection.description,
                      location: _editCollection.location,
                      imageUrl: _editCollection.imageUrl);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                textInputAction: TextInputAction.next,
                focusNode: _locationFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (_value) {
                  _editCollection = Collection(
                      id: _editCollection.id,
                      title: _editCollection.title,
                      description: _editCollection.description,
                      location: _value,
                      imageUrl: _editCollection.imageUrl);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
                onSaved: (_value) {
                  _editCollection = Collection(
                      id: _editCollection.id,
                      title: _editCollection.title,
                      description: _value,
                      location: _editCollection.location,
                      imageUrl: _editCollection.imageUrl);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imageController,
                focusNode: _imageFocus,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (_value) {
                  _editCollection = Collection(
                      id: _editCollection.id,
                      title: _editCollection.title,
                      description: _editCollection.description,
                      location: _editCollection.location,
                      imageUrl: _value);
                },
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.only(top: 5, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: _imageController.text.isEmpty
                    ? Text("Enter URL")
                    : FittedBox(
                        child: Image.network(_imageController.text),
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
