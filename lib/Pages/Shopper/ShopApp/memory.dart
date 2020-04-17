import 'package:flutter/material.dart';
import 'package:finaldukkan1/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Memory extends StatefulWidget {
  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<Memory> {
  @override
  Widget build(BuildContext context) {
  }
}
final List<Map> allProductsListMemory = new List();

Widget MemoryHistory(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey,
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
              if (snapshot.data['CompletedOrders'].length == 0) {
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("No History" , style: TextStyle(fontSize:30.0),),
                  ],
                ));
              } 
              else {
                allProductsListMemory.removeRange(0, allProductsListMemory.length);
                for(var i = 0 ; i < snapshot.data['CompletedOrders'].length ; i++){
                  
                  if(idOrderslist[numbOfOrderSelectedShopper] == snapshot.data['CompletedOrders'][i]['OrderId']){
                    for (var j = 0; j < snapshot.data['CompletedOrders'][i]['Products'].length; j++) {
                      var newProduct1 ={
                        'name': snapshot.data['CompletedOrders'][i]['Products'][j]['name'],
                        'price':int.parse(snapshot.data['CompletedOrders'][i]['Products'][j]['price']),
                        'image':snapshot.data['CompletedOrders'][i]['Products'][j]['image'],
                        'value': snapshot.data['Products'][i]['value'],
                        'available': snapshot.data['Products'][i]['available'],
                        'id':snapshot.data['CompletedOrders'][i]['OrderId']
                      };
                      var exist = false;
                      for (var k = 0; k < allProductsListMemory.length; k++) {
                        if (newProduct1['id'] ==
                            allProductsListMemory[k]['id'].toString()) {
                          exist = true;
                        }
                      }
                      if (exist == false) {
                        allProductsListMemory.add(newProduct1);
                      }
                    }
                  }
                }
              }
            }
            return NewMemoryProductListing();
        }),
      ],
    ),
  );
}


class NewMemoryProductListing extends StatefulWidget {
  @override
  _NewMemoryProductListingState createState() => _NewMemoryProductListingState();
}


class _NewMemoryProductListingState extends State<NewMemoryProductListing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.81,
      child: new GridView.count(
        crossAxisCount: 2,
        children: List.generate(allProductsListMemory.length, (index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 100.0,
                  child: FlatButton(
                    onPressed: () {
                      print('hey you');
                      // var exist = false;
                      // if(myCart.length == 0){
                        
                        
                      //   var changeMyCartProducts = {
                      //     'name':allProductsListMemory[index]['name'],
                      //     'price':allProductsListMemory[index]['price'],
                      //     'available':allProductsListMemory[index]['available'],
                      //     'image':allProductsListMemory[index]['image'],
                      //     'value':allProductsListMemory[index]['value']
                      //   };
                      //     myCart.add(changeMyCartProducts);
                      // }
                      // else{
                        
                      //   for (var i = 0; i < myCart.length; i++) {
                      //     if (allProductsList[index]['name'] == myCart[i]['name']) {
                      //       exist = true;
                      //     }
                      //   }
                      //   if (exist == false) {
                          
                      //     var changeMyCartProducts = {
                                
                      //           'name':allProductsList[index]['name'],
                      //           'price':allProductsList[index]['price'],
                      //           'available':allProductsList[index]['available'],
                      //           'image':allProductsList[index]['image'],
                      //           'cart':allProductsList[index]['cart'],
                      //           'favorite':allProductsList[index]['favorite'],
                      //           'value':allProductsList[index]['value']

                      //         };
                          
                      //     myCart.add(changeMyCartProducts);
                          
                      //   }
                      // }
                      // for (var i = 0; i < myCart.length; i++) {
                          
                      //   if(allProductsList[index]['image'] == myCart[i]['image']){
                          
                      //     var myCartPriceProduct = {
                      //       'name':myCart[i]['name'],
                      //       'image': myCart[i]['image'],
                      //       'price':myCart[i]['price'],
                      //     };

                      //     var myCartValueProduct = {
                      //       'image':myCart[i]['image'],
                      //       'value' : 1,
                      //     };
                          
                      //     var allExist = false;
                      //     for(var i = 0; i < myCartPricesList.length ; i++){
                      //       if( allProductsList[index]['image'] == myCartPricesList[i]['image']){
                      //         allExist = true;
                              
                      //         break;
                      //       }
                      //     }
                      //     if(allExist == false){
                      //       myCartValuesList.add(myCartValueProduct);
                      //       myCartPricesList.add(myCartPriceProduct);
                      //     }
                      //     if(allExist==true){
                            
                      //       for (var i = 0; i < myCartValuesList.length; i++) {
                      //         if(allProductsList[index]['image'] == myCartValuesList[i]['image']){
                      //           myCartValuesList[i]['value'] += 1;
                      //           myCartPricesList[i]['price'] = myCart[i]['price']*myCartValuesList[i]['value'];  
                      //         }
                      //       }
                      //     }
                      //   }
                      // }
                      // (context as Element).reassemble();
                    },
                    child: Image.network(allProductsList[index]['image']),
                    
                  )),
                  ],
          );
        }),
      ),
    );
  }
}