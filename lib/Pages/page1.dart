// import 'package:flutter/material.dart';
// import '../Pages/phone.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:trial12/Pages/Shopper/available.dart';
// // import 'package:trial12/Pages/Vendor/venmainapp.dart';
// // import 'package:trial12/Pages/Vendor/venmap.dart';
// // import '../Services/camera.dart';
// import 'Vendor/vendcam.dart';


// class FirstRoute extends StatefulWidget {
//   @override
//   _FirstRouteState createState() => _FirstRouteState();
// }

// class _FirstRouteState extends State<FirstRoute> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(15, 76, 117, 100),
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(27, 38, 44, 100),
//         title: Center(
//           child: Text(
//             'الدكان',
//             style: TextStyle(color: Colors.white, fontSize: 50.0),
//           ),
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 45.0, 0, 20.0),
//                 child: Image.asset("images/cart-1.png"),
//                 width: 200.0,
//                 height: 200.0,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                   margin: EdgeInsets.only(top: 70.0, bottom: 30.0),
//                   width: MediaQuery.of(context).size.width * 0.65,
//                   height: 50.0,
//                   child: FlatButton(
//                     color: Colors.green,
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(30.0),
//                     ),
//                     child: Text(
//                       'أدخل رقم هاتفك',
//                       style: TextStyle(color: Colors.white ),
//                     ),
//                     onPressed: () {
//                       print("Phone number");
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => PhonePage()));
//                     },
//                   )),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                   margin: EdgeInsets.only(top: 20.0),
//                   child: FlatButton(
//                     color: Colors.green,
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(30.0),
//                     ),
//                     child: Text(
//                       'مشترك',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     onPressed: () {
//                       print("vend app");
//                       Navigator.push(
//                         context,
//                         // MaterialPageRoute(builder: (context) => main()),
//                         MaterialPageRoute(builder: (context) => CameraTab()),
//                         // 
//                       );
//                     },
//                   ))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:finaldukkan1/globals.dart';
import '../Pages/phone.dart';
import 'Shopper/available.dart';
import 'Vendor/vendmainapp.dart';
import 'phone.dart';
import 'page3.dart';


class FirstRoute extends StatefulWidget {
  
  @override
  _FirstRouteState createState() => _FirstRouteState();
 


  
}

class _FirstRouteState extends State<FirstRoute> {
   @override
  void initState() {
    checkuser();
  }
   void  checkuser() async {
   final FirebaseUser user =  await FirebaseAuth.instance.currentUser();
               if (user !=null){
                 
                  Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>ThirdPage())
                                    );
                                    print(user);
                                    print(phoneNumber);

               }
               else{
                   Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => PhonePage()));
               }
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
                       //checkuser();
                      print("Phone number");
                      
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => PhonePage()));
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
                        MaterialPageRoute(builder: (context) => MainVend()),
                        
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }