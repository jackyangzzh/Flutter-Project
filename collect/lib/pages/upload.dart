import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File file;

  void handleTakePhoto() async {
    // Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this.file = file;
    });
  }

  void handleFromPhotos() async {
    // Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  Text buildUploadPage() {
    return Text("File Loaded");
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
