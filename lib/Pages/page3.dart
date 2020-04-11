import 'package:finaldukkan1/globals.dart';
import 'package:flutter/material.dart';
import '../Pages/Shopper/shopsignup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Pages/Vendor/Vendsignup.dart';



class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 76, 117, 100),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 38, 44, 100),
        title: Center(
          child: Text(
            'الدكان',
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          ),
        ),
      ),
      body:  Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height* 0.4,
                  color: Colors.white,
                  child: FlatButton(
                      child: Image.asset('images/vendor1.png',),    
                      onPressed: () {
                        
                        vendPhone = tempPhone;
                      
                        Firestore.instance.collection('Vendors').document(tempPhone).setData({'phonenumber' :tempPhone});
                        Firestore.instance.collection('Vendors').document(tempPhone).updateData({'Pinfo':{}});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpVendor()),
                        );
                      })),
              Container(
                height: MediaQuery.of(context).size.height* 0.4,
                width: MediaQuery.of(context).size.width * 1,
                color: Colors.white,
                // padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 15.0),
                child: FlatButton(
                    child: Image.asset('images/shopper.png'),
                    onPressed: () {
                      shopPhone = tempPhone;
                      
                      Firestore.instance.collection('Shoppers').document(shopPhone).setData({'phonenumber' :tempPhone});
                      Firestore.instance.collection('Shoppers').document(shopPhone).updateData({'Pinfo':{}});
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpShopper()),
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}