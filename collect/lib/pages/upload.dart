import 'dart:io';

import 'package:collect/models/user.dart';
import 'package:collect/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as image;
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {
  final User currentUser;

  Upload({this.currentUser});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File file;
  bool isLoading;
  String postId = Uuid().v4();

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

  void handleSubmit() {
    setState(() {
      isLoading = true;
    });
  }

  void compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    image.Image imageFile = image.decodeImage(file.readAsBytesSync());
    File('$path/img_$postId.jpg')
      ..writeAsBytesSync(image.encodeJpg(imageFile, quality: 100));
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
            onPressed: isLoading ? null : () => handleSubmit(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          isLoading ? linearProgress : Text(""),
          SizedBox(
            child: Image(
              image: FileImage(file),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Caption", border: InputBorder.none),
            ),
          ),
          Divider(),
          ListTile(
            // leading: Icon(Icons.location_on),
            title: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                  decoration: InputDecoration(
                      hintText: "Location", border: InputBorder.none)),
            ),
            trailing: IconButton(
              icon: Icon(Icons.location_searching),
              onPressed: () {},
            ),
          ),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Description", border: InputBorder.none),
            ),
          ),
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
