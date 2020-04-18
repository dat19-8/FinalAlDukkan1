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
import '../Pages/Vendor/vendmainapp.dart';
import 'package:better_uuid/uuid.dart';
//class FirstRoute extends StatefulWidget {
//  @override
//  _FirstRouteState createState() => _FirstRouteState();
//}
//
//class _FirstRouteState extends State<FirstRoute> {
//  @override
//  void initState() {
//    checkuser();
//  }
//
//  void checkuser() async {
//    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    if (user != null) {
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => ThirdPage()));
//      print (user);
//      print(phoneNumber);
////    var documentt= Firestore.instance
////        .collection('Vendors')
////        .document(vendPhone).snapshots();
////    builder: (context, snapshot){
////    if (snapshot.data.)
////    if (documentt=phoneNumber){
////      print ("yes");
////    }
////    else {
////      print ("no");
////    }
////    print (documentt);
//
//
////      Firestore.instance
////        .collection('Vendors')
////        .document(vendPhone).get().
////    then((DocumentSnapshot ds){
////      // if (
////     print(  ds.data['Orders']['Pinfo']['phone']);
////     print ("hi");
////         //== phoneNumber
//////         {
//////           Navigator.pushReplacement(
//////        context, MaterialPageRoute(builder: (context) => ShopApp()));
//////         }
//////       else {
//////         print ("no");
////      });
//////      });
////      print ("hiiiiiiiiiii");
//
////      if( Firestore.instance.collection("Vendors").document(phoneNumber).snapshots() != null)
////         {
////           print ("hi");
////           Navigator.pushReplacement(
////               context, MaterialPageRoute(builder: (context) => Vendapp()));
////           print (phoneNumber);
////         }
////
////         else if( Firestore.instance.collection("Shoppers").document(phoneNumber).snapshots() != null){
////        print ("hellooo");
////           Navigator.pushReplacement(
////       context, MaterialPageRoute(builder: (context) => ShopApp()));
////
////    }
////      else
////    {
////
////    Navigator.pushReplacement(
////       context, MaterialPageRoute(builder: (context) => ThirdPage()));
////    }
//
//
//
//
//    } else {
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => PhonePage()));
//    }
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Color.fromRGBO(15, 76, 117, 100),
//      appBar: AppBar(
//        backgroundColor: Color.fromRGBO(27, 38, 44, 100),
//        title: Center(
//          child: Text(
//            'الدكان',
//            style: TextStyle(color: Colors.white, fontSize: 50.0),
//          ),
//        ),
//      ),
//      body: Column(
//        children: <Widget>[
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.fromLTRB(0, 45.0, 0, 20.0),
//                child: Image.asset("images/cart-1.png"),
//                width: 200.0,
//                height: 200.0,
//              ),
//            ],
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                  margin: EdgeInsets.only(top: 70.0, bottom: 30.0),
//                  width: MediaQuery.of(context).size.width * 0.65,
//                  height: 50.0,
//                  child: FlatButton(
//                    color: Colors.green,
//                    shape: new RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(30.0),
//                    ),
//                    child: Text(
//                      'أدخل رقم هاتفك',
//                      style: TextStyle(color: Colors.white ),
//                    ),
//                    onPressed: () {
////                      print("Phone number");
//                      // Navigator.pushReplacement(context,
//                      //     MaterialPageRoute(builder: (context) => PhonePage()));
//                    },
//                  )),
//            ],
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                  margin: EdgeInsets.only(top: 20.0),
//                  child: FlatButton(
//                    color: Colors.green,
//                    shape: new RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(30.0),
//                    ),
//                    child: Text(
//                      'مشترك',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () {
//                      print("vend app");
//                      Navigator.push(
//                        context,
//                        // MaterialPageRoute(builder: (context) => main()),
//                        MaterialPageRoute(builder: (context) => CameraTab()),
//                        //
//                      );
//                    },
//                  ))
//            ],
//          )
//        ],
//      ),
//    );
//  }
//}


class FirstRoute extends StatefulWidget {

  @override
  _FirstRouteState createState() => _FirstRouteState();




}

class _FirstRouteState extends State<FirstRoute> {

  @override
  void initState() {
//    print (phoneNumber);
    checkuser();
  }
  void  checkuser() async {
    final FirebaseUser user =  await FirebaseAuth.instance.currentUser();
    if (user !=null){
      StreamBuilder(
          stream: Firestore.instance
              .collection('Vendors')
              .document('00000001')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text('No data in DB '));
            else {
              if (snapshot.data['Products'].length == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Text(
                          "You have no Products",
                          style: TextStyle(fontSize: 30.0),
                        )),
                  ],
                );
              } else {
                print("theres data");
              }
          }
      );
//      var phonee= user.phoneNumber;
//      var newphone=phonee.substring(4);
//      String x="12";
//
//      print(x);
//print (user.phoneNumber);

//    print(phoneNumber);
//      Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(
//              builder: (context) =>ThirdPage())
//      );
//      print(user);
//
//

//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => MainVend()));
//
//           print (user.phoneNumber);
//         }
//
//         else if( (Firestore.instance.collection("Shopers").document("user.phoneNumber").snapshots())!null){
//        print ("hellooo");
//           Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (context) => MainShop()));
//
//    }
//      else
//    {
//      print("hello");
//
//    Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (context) => ThirdPage()));
  //  }


//StreamBuilder(
//  stream: Firestore.instance.collection("Shoppers").snapshots(),
//  builder:(conext,snapshot){
////  print(snapshot.data.documents["+96176080604"]['Pinfo']);
//
//
//  }
//);
//    print (user.phoneNumber);
//    StreamBuilder(
//        stream: Firestore.instance
//            .collection('Shoppers')
//            .document(user.phoneNumber)
//            .snapshots(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData)
//            print('No data in DB ');
//          else
//            print ("data");

//        });


    }
    else{
      print ("yes");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PhonePage()));
    }
  }
    var shopper_found = false;
    var vendor_founf = false;
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
      body: Column(
        children: <Widget>[
         streambuilder Row(
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
                    print (phoneNumber);
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
