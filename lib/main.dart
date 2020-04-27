import 'package:finaldukkan1/Pages/phone.dart';
import 'package:flutter/material.dart';
import './Pages/page1.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var title = "Login";

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: PhonePage()

         );

  }
}
