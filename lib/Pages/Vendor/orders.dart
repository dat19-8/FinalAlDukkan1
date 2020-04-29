import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:finaldukkan1/globals.dart';
import './ListOrders.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

final List<Map> allShoppers = new List();


var ordersNumber;
var numberOfOrder;

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(27, 38, 44, 100),
        title: Text(
          'الدكان',
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder(
              stream: Firestore.instance
                  .collection('Vendors')
                  .document(vendPhone)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: Text('No data in DB '));
                else {
                  if (snapshot.data['Orders'].length == 0) {
                    return Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("You have no Orders" , style: TextStyle(fontSize:30.0),),
                      ],
                    ));
                  } else {
                    allShoppers.removeRange(0, allShoppers.length);
                    for (var i = 0; i < snapshot.data['Orders'].length; i++) {
                       if(snapshot.data['Orders'][i]['completed'] == false);
                       var newshopper = {
                          'shopperName': snapshot.data['Orders'][i]['Pinfo']
                              ['name'],
                          'shopperAddress': snapshot.data['Orders'][i]['Pinfo']
                              ['address'],
                          'shopperPhoneNumber': snapshot.data['Orders'][i]
                              ['Pinfo']['phone'],
                          'time':snapshot.data['Orders'][i]
                              ['Pinfo']['timeOfOrder'],
                        };
                        allShoppers.add(newshopper);
                      ordersNumber = snapshot.data['Orders'].length;
                      
                    }
                  }
                }
                return OrdersListing();
              }),
        ],
      ),
    );
  }
}

class OrdersListing extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.78,
      child: new ListView(
        padding: EdgeInsets.only(bottom:10.0),
        children: List.generate(ordersNumber, (index) {
          return Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 50.0,
                padding: EdgeInsets.all(0),
                child: FlatButton(
                  child: Text("Order ${index + 1} >"),
                  onPressed: () {
                    numberOfOrderSelected = index;
                    
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListOrders()),
                        );
                    // print("show all products1");
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
