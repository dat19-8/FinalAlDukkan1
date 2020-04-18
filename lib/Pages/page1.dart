import 'package:flutter/material.dart';
import '../Pages/phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:trial12/Pages/Shopper/available.dart';
// import 'package:trial12/Pages/Vendor/venmainapp.dart';
// import 'package:trial12/Pages/Vendor/venmap.dart';
// import '../Services/camera.dart';
import 'Vendor/vendcam.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finaldukkan1/globals.dart';
import 'page3.dart';
import '../pages/Shopper/ShopApp/mainshop.dart';
import '../Pages/Vendor/vendapp.dart';
import 'package:better_uuid/uuid.dart';

var shopper_found = false;
var vendor_found = false;
class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();}


class _FirstRouteState extends State<FirstRoute> {
//  @override
//  void initState() {
//
//    checkuser();
//  }
//  void  checkuser() async {
//    final FirebaseUser user =  await FirebaseAuth.instance.currentUser();
//    if (user !=null){
//
////      if(vendor_found ==true){
////      vendPhone = user.phoneNumber;
////      Navigator.pushReplacement(
////      context, MaterialPageRoute(builder: (context) => Vendapp()));
////    }
//    print(user.phoneNumber);
//    print (user.uid);
//
//    }
//    else{
//      print ("yes");
//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder: (context) => PhonePage()));
//    }
//  }

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
      body:

      Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 45.0, 0, 20.0),
                child: Image.asset("images/cart-1.png"),
                width: 200.0,
                height: 200.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              StreamBuilder(
                  stream: Firestore.instance
                      .collection('Shoppers')
                  .document("12345678")

                      .snapshots(),
                  builder:(context, snapshot){


// for(int i= 0; i < snapshot.data.documents.length; i++) {
//
//      if (snapshot.data.documents[i].data['phonenumber'].value=='"0303030303"')
//print ("shopper");
//
//      else if (snapshot.data.documents[i].data['phonenumber'].value!='"0303030303"') {
//        print ("vendor");
//      }
//    }



                   if (snapshot.hasData){
//            shopper_found = true;

                      print("  vendor") ;
                      ;}
                    else if (!snapshot.hasData){
//            vendor_found =true;
                      print ("  not a vendor");
                    }
//          checkuser();
                    return Text('no Db' , style: TextStyle(color:Colors.transparent),);
                  }),
              Container(
                  margin: EdgeInsets.only(top: 70.0, bottom: 30.0),
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 50.0,
                  child: FlatButton(
                    color: Colors.green,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'أدخل رقم هاتفك',
                      style: TextStyle(color: Colors.white ),
                    ),
                    onPressed: () {
//                      print("Phone number");

//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => PhonePage()));
                    },
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: FlatButton(
                    color: Colors.green,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'مشترك',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      print("vend app");
                      Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => main()),
                        MaterialPageRoute(builder: (context) => CameraTab()),
                        //
                      );
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }
}