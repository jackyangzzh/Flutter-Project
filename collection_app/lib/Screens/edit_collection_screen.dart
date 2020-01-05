import '../Providers/product_provider.dart';
import 'package:flutter/material.dart';
import '../Providers/collection.dart';
import 'package:provider/provider.dart';

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
  var _isInit = true;
  var _initValue = {'title': '', 'description': '', 'imageUrl': ''};
  var _loading = false;

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

  Future<void> _saveForm() async {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _loading = true;
    });

    if (_editCollection.id != null) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateItem(_editCollection.id, _editCollection);
      setState(() {
        _loading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .addItem(_editCollection);
      } catch (error) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Something went wrong'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(_).pop();
                      },
                    )
                  ],
                ));
      } finally {
        setState(() {
          _loading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final itemId = ModalRoute.of(context).settings.arguments as String;
      if (itemId != null) {
        _editCollection = Provider.of<ProductProvider>(context, listen: false)
            .findById(itemId);
        _initValue = {
          'title': _editCollection.title,
          'location': _editCollection.location,
          'description': _editCollection.description,
          'imageUrl': ''
        };
        _imageController.text = _editCollection.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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
        child: _loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              )
            : Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValue['title'],
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
                            imageUrl: _editCollection.imageUrl,
                            isFavoriate: _editCollection.isFavoriate);
                      },
                      validator: (_value) {
                        if (_value.isEmpty) {
                          return 'Please enter a title';
                        }
                        if (_value.length > 60){
                          return 'Please keep the title short (less than 60 characters)';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue['location'],
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
                            imageUrl: _editCollection.imageUrl,
                            isFavoriate: _editCollection.isFavoriate);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue['description'],
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
                            imageUrl: _editCollection.imageUrl,
                            isFavoriate: _editCollection.isFavoriate);
                      },
                      validator: (_value) {
                        if (_value.isEmpty) {
                          return 'Please enter some description';
                        }
                        if (_value.length < 10) {
                          return 'Please describe a bit more!';
                        }
                        return null;
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
                            imageUrl: _value,
                            isFavoriate: _editCollection.isFavoriate);
                      },
                      validator: (_value) {
                        if (_value.isEmpty) {
                          return 'Please add an image!';
                        }
                        if (!_value.startsWith('http') ||
                            !_value.startsWith('https')) {
                          return 'Please enter a valid URL';
                        }
                        return null;
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      margin: EdgeInsets.only(top: 5, right: 10),
                      child: _imageController.text.isEmpty
                          ? Container()
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
