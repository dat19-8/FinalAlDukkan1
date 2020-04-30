import 'package:flutter/material.dart';
import 'package:finaldukkan1/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './acceptedMemory.dart';

class MemoryListing extends StatefulWidget {
  @override
  _MemoryListingState createState() => _MemoryListingState();
}

class _MemoryListingState extends State<MemoryListing> {
  @override
  Widget build(BuildContext context) {
  }
}
final List<Map> allProductsListMemory = new List();

Widget MemoryTab(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
    children: <Widget>[
      StreamBuilder(
          stream: Firestore.instance
              .collection('Vendors')
              .document(selectedShopPhone)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text('No data in DB '));
            else {
              idOrderslist.removeRange(0, idOrderslist.length);
              statusOrdersList.removeRange(0, statusOrdersList.length);
              if (snapshot.data['CompletedOrders'].length == 0) {
                
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("ليس لديك طلبيّات سابقة" , style: TextStyle(fontSize:30.0),),
                  ],
                ));
              } 
              else if(snapshot.data['CompletedOrders'].length > 0) {
                for(var i = 0 ; i < snapshot.data['CompletedOrders'].length ; i++){
                  if(shopPhone == snapshot.data['CompletedOrders'][i]['Pinfo']['phone']){
                    var completedStatus = snapshot.data['CompletedOrders'][i]['completed'];
                    statusOrdersList.add(completedStatus);
                    
                      var newId = snapshot.data['CompletedOrders'][i]['OrderId'];
                      var exist = false;
                      for (var k = 0; k < allProductsListMemory.length; k++) {
                        if (newId ==idOrderslist[k]) {
                          exist = true;
                        }
                      }
                      if (exist == false) {
                        idOrderslist.add(newId);
                      }
                    }
                }
              }
              if(snapshot.data['DeclinedOrders'].length > 0){
                  for(var i = 0 ; i < snapshot.data['DeclinedOrders'].length ; i++){
                  if(shopPhone == snapshot.data['DeclinedOrders'][i]['Pinfo']['phone']){
                    var completedStatus = snapshot.data['DeclinedOrders'][i]['completed'];
                    statusOrdersList.add(completedStatus);
                      var newId = snapshot.data['DeclinedOrders'][i]['OrderId'];
                      
                      var exist = false;
                      for (var k = 0; k < allProductsListMemory.length; k++) {
                        if (newId ==idOrderslist[k]) {
                          exist = true;
                        }
                      }
                      if (exist == false) {
                        idOrderslist.add(newId);
                        
                      }
                    }
                }
              }
            }
          return ProductListing();
        }),
      ],
    ),
  );
}


class ProductListing extends StatefulWidget {
  @override
  _ProductListingState createState() => _ProductListingState();
}


class _ProductListingState extends State<ProductListing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.76,
      child: new ListView(
        padding: EdgeInsets.only(bottom:10.0),
        children: List.generate(idOrderslist.length, (index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 100.0,
                  child: FlatButton(
                    child: Text("طلب ${index + 1} >"),
                    onPressed: () {
                    numbOfOrderSelectedShopper = index;
                    
                    print('statusOrdersList:      $statusOrdersList');
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Memory()),
                        );
                  },
                    
                  )),
                  ],
          );
        }),
      ),
    );
  }
}