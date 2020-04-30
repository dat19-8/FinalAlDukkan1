import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:finaldukkan1/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CameraTab extends StatefulWidget {
  @override
  _CameraTabState createState() => _CameraTabState();
}

final List<Map> myProducts = List();
final List<Map> tempProducts = List();
List tempUrls = [];


class _CameraTabState extends State<CameraTab> {
  List<Asset> images = List<Asset>();
  String _error;


  // File imageFile;
  // Widget buildGridView() {
  //   if (images != null)
  //     return GridView.count(
  //       crossAxisCount: 3,
  //       children: List.generate(images.length, (index) {
  //         Asset asset = images[index];
  //         return AssetThumb(
  //           asset: asset,
  //           width: 300,
  //           height: 300,
  //         );
  //       }),
  //     );
  //   else
  //     return Container(color: Colors.white);
  // }
  _openGallery(BuildContext context) async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;
    tempProducts.removeRange(0, tempProducts.length);
    tempUrls.removeRange(0, tempUrls.length);
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
    print("**********************************************************************************************************************************************");
    Future f = images[0].metadata;
    f.then((value) { print(value); });
    print('images.length : ${images.length}');
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

    print('imageList: $images');
    for (var i=0; i<images.length;i++) {
      ByteData byteData = await images[i].getThumbByteData(
          300, 300, quality: 30);

      byteData = await images[i].requestOriginal();
      List<int> imageData = byteData.buffer.asUint8List();
      String myNewfileName = images[i].name;
      StorageReference ref = FirebaseStorage.instance.ref().child(
          "images/${vendPhone}/${myNewfileName}");
      StorageUploadTask uploadTask = ref.putData(imageData);

      String url = await (await uploadTask.onComplete).ref.getDownloadURL();
      print("URL is $url");
      var newProduct1 = {
     'image': url,
     'name': "name",
     'price': "0000",
     'cart': false,
     'available': true,
     'favorite': false,
     'value': 1,
   };
   myProducts.add(newProduct1);

    }
    print("--------------------------------------------------------------------------------------");
 
    print('before firestore myProducts: $myProducts');
    for (var i = 0; i < myProducts.length -1; i++) {
      for (var j = 1; j < myProducts.length ; j++) {
        if (myProducts[i]['image'] == myProducts[j]['image']) {
          myProducts.removeAt(j);
        }
      }
    }
   Firestore.instance
       .collection('Vendors')
       .document(vendPhone)
       .updateData({'Products': myProducts});
  }

  _openCamera(BuildContext context) async {
    print("camera");
    var pictureCamera = await ImagePicker.pickImage(source: ImageSource.camera , imageQuality: 50);
    String myNewfileName = basename(pictureCamera.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("images/${vendPhone}/${myNewfileName}");
    print("images/${vendPhone}/${myNewfileName}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(pictureCamera);
    print("after StorageUploadTask");
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print("after StorageTaskSnapshot");

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
      'value': 1,

    };
    myProducts.add(newProduct1);

    for (var i = 0; i < myProducts.length -1; i++) {
      for (var j = 1; j < myProducts.length ; j++) {
        if (myProducts[i]['image'] == myProducts[j]['image']) {
          myProducts.removeAt(j);
        }
      }
    }

    Firestore.instance
        .collection('Vendors')
        .document(vendPhone)
        .updateData({'Products': myProducts});
  }

  Future uploadPic(BuildContext context) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("الدكان")),
        backgroundColor: Color.fromRGBO(27, 38, 44, 100),
      ),
      body: AlertDialog(
        title: Text(" إختار"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: <Widget>[
              GestureDetector(
                child: Text("  كاميرا"),
                onTap: () {
                  _openCamera(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text(" صالة عرض"),
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



//    StorageReference firebaseStorageRef = FirebaseStorage.instance
//        .ref()
//        .child("images/${vendPhone}/${myNewfileName}");
//    StorageUploadTask uploadTask = firebaseStorageRef.putFile(pictureGallery);
//    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
//    final String url = (await downloadUrl.ref.getDownloadURL());
//    print("URL is $url");
//    new StreamBuilder(
//        stream: Firestore.instance
//            .collection('Vendors')
//            .document(vendPhone)
//            .snapshots(),
//        builder: (context, snapshot) {
//          if (snapshot.data['Products'].length != 0) {
//            for (var i = 0; i < snapshot.data['Products'].length; i++) {
//              myProducts.add(snapshot.data['Products'][i]);
//            }
//          }
//
//          return Text("done" , style: TextStyle(color: Colors.transparent),);
//        });