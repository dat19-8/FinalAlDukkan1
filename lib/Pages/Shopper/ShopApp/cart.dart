import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './shopapp.dart';
import 'package:finaldukkan1/globals.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

final List<List> placingOrder = new List();
final List<Map> allOrders = new List();



class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.68,
              child: new GridView.count(
                crossAxisCount: 2,
                children: List.generate(myCart.length, (index) {
                  return Column(
                    children: <Widget>[
                      Container(
                          width: 170.0,
                          height: 145.0,
                          child: FlatButton(
                            onPressed: () {
                              print('${myCart[index].value}');
                            },
                            child: Image.network(myCart[index].image),
                          )),
                      Text("name : ${myCart[index].name}"),
                      Text("price : ${myCart[index].price}"),
                    ],
                  );
                }),
              ),
            ),
            
            StreamBuilder(
                stream: Firestore.instance
                    .collection('Vendors')
                    .document(selectedShopPhone)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: Text('No data in DB '));
                  else {
                    if (snapshot.data['Orders'].length == 0) {
                      return Center(child: Text("Place your order"));
                    } 
                    
                    else {
                      for (var i = 0; i < snapshot.data['Orders'].length; i++) {
                        allOrders.add(snapshot.data['Orders'][i]);
                      }
                    }
                  }
                  return Text("done" , style: TextStyle(color:Colors.transparent , fontSize: 2.0,));
                }),
            new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      
                      var myOrder = {
                        'Pinfo': {
                          'name': shopperName,
                          'address': shopperAddress,
                          'phone': shopPhone
                        },
                        'Products': newMapCart,
                        'completed': false
                      };
                      
                      allOrders.add(myOrder);
                      for (var i = 0; i < allOrders.length - 1; i++) {
                        for (var j = 2; j < allOrders.length ; j++) {
                          if (allOrders[i]['Pinfo']['name'] == allOrders[j]['Pinfo']['name']) {
                            allOrders.removeAt(i);
                          }
                          
                        }
                      }
                      

                      Firestore.instance
                          .collection('Vendors')
                          .document(selectedShopPhone)
                          .updateData({
                        'Orders': allOrders
                      });
                      

                    },
                    child: Icon(Icons.navigate_next),
                  )
                ])
          ],
        ));
  }
}
