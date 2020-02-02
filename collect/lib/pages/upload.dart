import 'dart:io';

import 'package:collect/models/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  final User currentUser;

  Upload({this.currentUser});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File file;

  void handleTakePhoto() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this.file = file;
    });
  }

  void handleFromPhotos() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  void clearImage() {
    setState(() {
      file = null;
    });
  }

  Scaffold buildUploadPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        title: Text("Edit your post"),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: Icon(
              Icons.file_upload,
              size: 32,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            child: Image(
              image: FileImage(file),
              fit: BoxFit.cover,
            ),
          )
        ]),
      ),
    );
  }

  Widget buildSelectPage() {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Take Photo"),
              onTap: handleTakePhoto,
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Upload from Photos"),
              onTap: handleFromPhotos,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buildSelectPage() : buildUploadPage();
  }
}
