import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:finaldukkan1/globals.dart';

class CameraTab extends StatefulWidget {
  @override
  _CameraTabState createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  // _uploadFile(File imageFile, String filename) async {
  //     print("in _upload file");
  //     StorageReference storageReference;
  //     storageReference = FirebaseStorage.instance.ref().child("images/$filename");

  //     print("before StorageUploadTask");
  //     final StorageUploadTask uploadTask = storageReference.putFile(imageFile);
  //     print("before StorageTaskSnapshot");
  //     final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
  //     final String url = (await downloadUrl.ref.getDownloadURL());
  //   print("URL is $url");
  //   }
  File imageFile;
  _openGallery(BuildContext context) async {
    var pictureGallery = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = pictureGallery;
    });
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    base64ImageUrl = base64Image;
    print('string is');
    print(base64Image);
    Navigator.of(context).pop();
  }
  File filename;
  _openCamera(BuildContext context) async {
    
    print("camera");
    var pictureCamera = await ImagePicker.pickImage(source: ImageSource.camera);
     // I can get the image .jpg
    imageSource = pictureCamera;
    print(imageSource);
    filename = pictureCamera;
    this.setState(() {
      filename = pictureCamera;
    });
    List<int> imageBytes = filename.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    
    base64ImageUrl = base64Image.toString();
    print('string is');
    print(base64Image);
    // _uploadFile(imageFile, base64Image);
    
    // Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: Text(" Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  
                  GestureDetector(
                    child: Text("  Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text(" Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                ],
              ),
            ),
      ),
    );
  }
}




