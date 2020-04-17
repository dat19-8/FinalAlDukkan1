import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:finaldukkan1/globals.dart';
import './vendmainapp.dart';
import 'venmap.dart';


class SignUpVendor extends StatefulWidget {
  @override
  _SignUpVendorState createState() => _SignUpVendorState();
}

class _SignUpVendorState extends State<SignUpVendor> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            'الدكان',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
        backgroundColor: Color.fromRGBO(27, 38, 44, 100),
      ),
      backgroundColor: Color.fromRGBO(15, 76, 117, 100),
      body: new Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
              width: 121.0,
              height: 70.0,
              color: Color.fromRGBO(50, 130, 184, 0),
              child: FloatingActionButton(
                child: Icon(Icons.camera_alt),
                
                onPressed: () {
                  print("camera");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => LandingScreen()),
                  // );
                },
              )),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "اسم المحل",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.white, width: 0.5, style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    // obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                    controller: _nameController,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(187, 215, 250, 100),
                      border: InputBorder.none,
                      hintText: 'سوق ابو علي',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "العنوان",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.white, width: 0.5, style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    // obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                    controller: _addressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '... اسم الشارع ، المبنى',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(60.0),
                      ),
                      color: Color.fromRGBO(50, 130, 184,100),
                      child: Icon(Icons.gps_fixed),
                      onPressed: () 
                      {
                        print("google maps here");
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoogleMaps()),
                      );
                      }
                      
              ),
            ),
              ],
            ),
            
          ),
          Divider(
            height: 24.0,
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 25.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Color.fromRGBO(50, 130, 184, 100),
                    onPressed: () {
                      if (_nameController.text.length == 0) {
                        Alert(context: context, title: 'أضف اسم المستخدم')
                            .show();
                      }
                      else {
                        // var finalAddress;
                        // if(_addressController.text ==null){
                        //   finalAddress = " ";
                        // }
                        // else{
                        //   finalAddress = _addressController.text;
                        // }
                        Firestore.instance
                            .collection('Vendors')
                            .document(tempPhone)
                            .updateData({
                          'Pinfo': {
                            'GoogleMaps':currentLocation,
                            'Phone': tempPhone,
                            'name': _nameController.text,
                            'address': _addressController.text,
                            'image':
                                'https://i7.pngguru.com/preview/871/494/366/grocery-store-computer-icons-food-clip-art-store.jpg'
                          }
                        });
                        Firestore.instance
                            .collection('Vendors')
                            .document(vendPhone)
                            .updateData({'Products': []});
                        Firestore.instance
                            .collection('Vendors')
                            .document(vendPhone)
                            .updateData({'Orders': []});
                        Firestore.instance
                            .collection('Vendors')
                            .document(vendPhone)
                            .updateData({'CompletedOrders': []});
                        // print("current Location: ${currentLocation}");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainVend()),
                        );
                      }
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "أفتح حساب ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
