import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './orders.dart';
import 'package:finaldukkan1/globals.dart';

class ListOrders extends StatefulWidget {
  @override
  _ListOrdersState createState() => _ListOrdersState();
}

final List<Map> myProductsListOrders = new List();
final List<Map> myUser = new List();

class _ListOrdersState extends State<ListOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
          Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 200.0,
                          height: 30.0,
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text("Name : ${allShoppers[numberOfOrderSelected]['shopperName']}")),
                      Container(
                          width: 200.0,
                          height: 30.0,
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text("Phone : ${allShoppers[numberOfOrderSelected]['shopperPhoneNumber']}")),
                      Container(
                          width: 200.0, height: 30.0, child:
                       Text("Address : ${allShoppers[numberOfOrderSelected]['shopperAddress']}"))
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                    return Center(child: Text("No Products in this order"));
                  } else {
                    myProductsListOrders.removeRange(0, myProductsListOrders.length);
                    for (var i = 0; i < snapshot.data['Orders'][numberOfOrderSelected]['Products'].length; i++) {
                       print("snapshot.data['Orders'][numberOfOrderSelected]['Products'].length");
                       print("${snapshot.data['Orders'][numberOfOrderSelected]['Products'].length}");
                       var newProduct = {
                          'name': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['name'],
                          'price': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['price'],
                          'value': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['value'],
                          'image': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['image'],
                        };
                        var exist = false;
                        for(var j = 0 ; j < myProductsListOrders.length ; j++){
                          if(newProduct['name'] == myProductsListOrders[j]['name']){
                            exist = true;
                          }  
                        }
                        if(exist == false) myProductsListOrders.add(newProduct);
                        
                        
                      
                      
                    }
                  }
                }
                return NewListingOrders();
              }),
          
          new Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: FlatButton(
                  child: Text("decline"),
                  onPressed: () => print("Decline"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: FlatButton(
                  child: Text("Accept : price here"),
                  // onPressed:() => myUser[0]['completed'] = true,
                  // onPressed: () => Firestore.instance.collection('Vendors').document(vendPhone).setData({['Orders'][numberOfOrderSelected]["completed"]:true}),
                  onPressed: () => print("hello"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NewListingOrders extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.6,
      child: new           ListView(
        semanticChildCount: 1,
        children: List.generate(myProductsListOrders.length, (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                  ),
                  Container(
                    width: 170.0,
                    height: 100.0,
                    child: Image.network(myProductsListOrders[index]['image']),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text("name : ${myProductsListOrders[index]['name']}"),
                  Text("price : ${myProductsListOrders[index]['price']}"),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
