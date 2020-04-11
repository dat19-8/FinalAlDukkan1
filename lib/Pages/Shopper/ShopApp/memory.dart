import 'package:flutter/material.dart';

class Memory extends StatefulWidget {
  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<Memory> {
  @override
  Widget build(BuildContext context) {
  }
}

Widget MemoryTab(BuildContext context) {
  return Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.yellow,
                child: 
                Text(
                'Get data from the data base list of orders by this user', 
                style: TextStyle(color: Colors.black),
                  
                ),
                
              ),
            )
          ],
        ),
    );
}