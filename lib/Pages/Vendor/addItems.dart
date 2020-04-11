import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaldukkan1/globals.dart';
import './vendcam.dart';
import './vendapp.dart';


class AddItemsDB extends StatelessWidget {
  final TextEditingController _nameController1 = new TextEditingController();
  final TextEditingController _priceController1 = new TextEditingController();
  final List<Map> myProducts =  List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 38, 44, 100),
        title: Center(
          child: Text(
            'الدكان',
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          ),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.width * 0.20,
              child: FlatButton(
                  onPressed: () {
                    print("alert");

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraTab()),
                    );
                  },
                  child: Icon(Icons.camera_alt))),
          Container(
            padding: EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.width * 0.20,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _nameController1,
              cursorColor: Colors.white,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefix: Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "name",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              autovalidate: true,
              autocorrect: false,
              maxLengthEnforced: true,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.width * 0.20,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _priceController1,
              cursorColor: Colors.white,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefix: Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "price",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              autovalidate: false,
              autocorrect: false,
              maxLengthEnforced: false,
            ),
          ),
          StreamBuilder(
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

                return Text("done");
              }),
          FlatButton(
              onPressed: () {
                var newProduct1 = {
                  'image': "https://www.freeiconspng.com/uploads/pepsi-icon-12.jpg",
                  'name': _nameController1.text,
                  'price': _priceController1.text,
                  'cart': false,
                  'available': true,
                  'favorite': false,
                  'value': 1
                };
                myProducts.add(newProduct1);
                
                for(var i = 0 ; i < myProducts.length -2; i++){
                
                    for(var j = 1 ; j <= myProducts.length -1;j++ ){
                      
                      if(myProducts[i]['name'] == myProducts[j]['name'])   {

                        myProducts.removeAt(j);
                      }
                    }
                }

                Firestore.instance
                    .collection('Vendors')
                    .document(vendPhone)
                    .updateData({'Products': myProducts});
                
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => Vendapp()));
              },
              child: Text("Add"))
        ]),
      ),
    );
  }
}
