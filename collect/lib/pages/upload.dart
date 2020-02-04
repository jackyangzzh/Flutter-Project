import 'dart:io';

import 'package:collect/models/user.dart';
import 'package:collect/widgets/progress.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as image;
import 'package:uuid/uuid.dart';
import 'home.dart';

class Upload extends StatefulWidget {
  final User currentUser;

  Upload({this.currentUser});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final _form = GlobalKey<FormState>();

  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File file;
  bool isLoading = false;
  bool autoValidate = false;
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

  Future<void> clearImage() async {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    setState(() {
      file = null;
    });
  }

  void handleSubmit() async {
    setState(() {
      isLoading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    createPost(
        mediaUrl: mediaUrl,
        location: locationController.text,
        caption: captionController.text,
        description: descriptionController.text);
    captionController.clear();
    locationController.clear();
    descriptionController.clear();
    setState(() {
      isLoading = false;
      file = null;
    });
  }

  void createPost(
      {String mediaUrl, String location, String caption, String description}) {
    postRef
        .document(widget.currentUser.id)
        .collection("userPosts")
        .document(postId)
        .setData({
      "postId": postId,
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "mediaUrl": mediaUrl,
      "caption": caption,
      "description": description,
      "location": location,
      "timestamp": timeStamp,
      'likes': {},
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageReference.child("post_$postId.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  void compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    image.Image imageFile = image.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(image.encodeJpg(imageFile, quality: 100));
    setState(() {
      file = compressedImageFile;
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
            onPressed: isLoading ? null : () => handleSubmit(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          autovalidate: autoValidate,
          child: Column(children: <Widget>[
            isLoading ? linearProgress(context) : Text(""),
            SizedBox(
              child: Image(
                image: FileImage(file),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.center,
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                controller: captionController,
                decoration: InputDecoration(
                    errorText: captionController.text.length > 20
                        ? "Enter something shorter!"
                        : null,
                    hintText: "Caption",
                    border: InputBorder.none),
                validator: (_value) {
                  if (_value.length < 2) {
                    return 'Please enter a title';
                  }
                  if (_value.length > 10) {
                    return 'Please keep the title short (less than 60 characters)';
                  }
                  return null;
                },
              ),
            ),
            Divider(),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.center,
              child: TextField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: "Description", border: InputBorder.none),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                        hintText: "Location", border: InputBorder.none)),
              ),
              trailing: IconButton(
                icon: Icon(Icons.location_searching),
                tooltip: "Current Location",
                onPressed: () {},
              ),
            ),
          ]),
        ),
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
