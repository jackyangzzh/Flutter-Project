import 'dart:io';

import 'package:collect/models/user.dart';
import 'package:collect/widgets/progress.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
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
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool _captionValid = true;

  File file;
  bool isLoading = false;
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

  void checkValid() {
    setState(() {
      captionController.text.isEmpty
          ? _captionValid = false
          : _captionValid = true;
    });
  }

  void handleSubmit() async {
    checkValid();
    if (_captionValid) {
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
        postId = Uuid().v4();
      });
    }
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

  Future<void> getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarkList = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarkList[0];
    String address =
        "${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
    locationController.text = address;
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
            child: TextField(
              maxLength: 60,
              maxLines: 2,
              // inputFormatters: [LengthLimitingTextInputFormatter(10)],
              style: TextStyle(fontSize: 20),
              controller: captionController,
              decoration: InputDecoration(
                  hintText: "Caption",
                  border: InputBorder.none,
                  errorText: _captionValid ? null : "Enter a caption"),
            ),
          ),
          Divider(),
          ListTile(
            // leading: Icon(Icons.location_on),
            title: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                  style: TextStyle(fontWeight: FontWeight.w300),
                  controller: locationController,
                  decoration: InputDecoration(
                      hintText: "Location", border: InputBorder.none)),
            ),
            trailing: IconButton(
              icon: Icon(Icons.location_searching),
              tooltip: "Current Location",
              onPressed: getUserLocation,
            ),
          ),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.center,
            child: TextField(
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              controller: descriptionController,
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
