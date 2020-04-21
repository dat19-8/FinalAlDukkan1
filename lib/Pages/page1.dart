import 'package:flutter/material.dart';
import '../Pages/phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Vendor/vendcam.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finaldukkan1/globals.dart';
import 'page3.dart';
import '../pages/Shopper/ShopApp/mainshop.dart';
import '../Pages/Vendor/vendapp.dart';
import 'package:better_uuid/uuid.dart';
import 'Shopper/available.dart';

var shopperFound = false;
var vendorFound = false;
//var phone=user.phoneNumber;
var currentphone;
class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
 @override
 void initState()  {

   Future.delayed(Duration(milliseconds: 1000), () {
     checkuser();
   });
 }
 void  checkuser() async {
   final FirebaseUser user =  await FirebaseAuth.instance.currentUser();
   currentphone=user.phoneNumber;
//   if (user !=null){
//     Future.delayed(Duration(milliseconds: 600), () {
//       // Code to execute
//
//     if(shopperFound == false && vendorFound == true){
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Vendapp()));
//     }
//     else if(vendorFound == false && shopperFound == true){
//       vendPhone = user.phoneNumber;
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => AvailableShopsPage()));
//     }
//
//     else if (vendorFound == false && shopperFound == false){
//       print("this phone number is not a user ");
//       print(currentphone);
       Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => ThirdPage()));
//     }
//     });
//
//
//   }
//   else{
//     print ("yes");
//      Navigator.pushReplacement(context,
//          MaterialPageRoute(builder: (context) => PhonePage()));
//   }
 }

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
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('Shoppers')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {



            if (!snapshot.hasData) {print('!snapshot.hasData');}
                     else{
                       for(var i = 0 ; i <snapshot.data.documents.length ; i++){
                          if( currentphone == snapshot.data.documents.elementAt(i).documentID ){
                            print(currentphone);
                            print('yes this is a shopper');
                            shopperFound = true;
                          }
                          }
                     }
                     return Text("hello" , style:  TextStyle(color:Colors.transparent),);
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('Vendors')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                     if (!snapshot.hasData) {print('!snapshot.hasData');}
                     else{
                       for(var i = 0 ; i <snapshot.data.documents.length ; i++){
                          print(snapshot.data.documents.elementAt(i).documentID);
                          
                          if( currentphone== snapshot.data.documents.elementAt(i).documentID ){
                            print(currentphone);
                            print('yes this is a vendor');
                            vendorFound = true;
                          }
                          }
                     }
                     return Text("hello" , style:  TextStyle(color:Colors.transparent),);
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
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                     print("Phone number");

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => PhonePage()));
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
                      
                      print('moshtarej');
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }
}
