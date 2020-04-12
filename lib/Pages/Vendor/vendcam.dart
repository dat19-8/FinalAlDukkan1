import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:finaldukkan1/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CameraTab extends StatefulWidget {
  @override
  _CameraTabState createState() => _CameraTabState();
}

final List<Map> myProducts = List();

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
    var pictureGallery =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    String myNewfileName = basename(pictureGallery.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("images/${vendPhone}/${myNewfileName}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(pictureGallery);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }

  _openCamera(BuildContext context) async {
    print("camera");
    var pictureCamera = await ImagePicker.pickImage(source: ImageSource.camera);
    // I can get the image .jpg
    String myNewfileName = basename(pictureCamera.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("images/${vendPhone}/${myNewfileName}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(pictureCamera);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String myImageUrl = (await downloadUrl.ref.getDownloadURL());
    print("URL is $myImageUrl");
    new StreamBuilder(
        stream: Firestore.instance
            .collection('Vendors')
            .document(vendPhone)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data['Products'].length != 0) {
            for (var i = 0; i < snapshot.data['Products'].length; i++) {
              myProducts.add(snapshot.data['Products'][i]);
            }
          }

          return Text("done" , style: TextStyle(color: Colors.transparent),);
        });
    var newProduct1 = {
      'image': myImageUrl,
      'name': "name",
      'price': "0000",
      'cart': false,
      'available': true,
      'favorite': false,
      'value': 1
    };
    myProducts.add(newProduct1);

    for (var i = 0; i < myProducts.length - 2; i++) {
      for (var j = 1; j <= myProducts.length - 1; j++) {
        if (myProducts[i]['image'] == myProducts[j]['image']) {
          myProducts.removeAt(j);
        }
      }
    }

    Firestore.instance
        .collection('Vendors')
        .document(vendPhone)
        .updateData({'Products': myProducts});

    // imageSource = pictureCamera;
    // print(imageSource);

    // this.setState(() {
    //   _filename = pictureCamera;
    // });
    // List<int> imageBytes = _filename.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);

    // base64ImageUrl = base64Image.toString();
    // print('string is');
    // print(base64Image);

    // _uploadFile(imageFile, base64Image);

    // Navigator.of(context).pop();
  }

  Future uploadPic(BuildContext context) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Al Dukkan"),
        // actions: <Widget>[
        //   Padding(
        //       padding: EdgeInsets.only(right: 10.0),
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.of(context).pop();
        //         },
        //         child: Icon(
        //           Icons.arrow_back_ios,
        //           size: 26.0,
        //         ),
        //       )),
        // ],
      ),
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

// my storage folder path : gs://finalaldukkan1.appspot.com/images
