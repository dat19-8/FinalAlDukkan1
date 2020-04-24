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
final List<Map>  allOrdersVendor = new List();
final List<Map> completedList = new List();
final List<Map> declinedList = new List();


var completedId ;
int _myFinalPriceInteger = 0;

_showAlertDialog(BuildContext context ) async{
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("إلغاء"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget deleteButton = FlatButton(
    child: Text("ACCEPT"),
    onPressed: () {
      for (var i = 0; i < allOrdersVendor.length; i++) {
        if(allOrdersVendor[i]['OrderId'] == completedId){
          allOrdersVendor[i]['completed'] = true;
          completedList.add(allOrdersVendor[i]);
          allOrdersVendor.removeAt(i);
        }
      }
      Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (context) => Orders()),
      );
      Firestore.instance
      .collection('Vendors')
      .document(vendPhone)
      .updateData({'CompletedOrders': completedList});
      Firestore.instance
        .collection('Vendors')
        .document(vendPhone)
        .updateData({'Orders': allOrdersVendor});
      
      
      
      
      Navigator.of(context, rootNavigator: true).pop('dialog');
      (context as Element).reassemble();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("انتباه"),
    content: Text(
        "do you want to accept this order $finalPrice LBP" , style: TextStyle(fontSize: 15.0),),
    actions: [
      cancelButton,
      deleteButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
_declineAlertDialog(BuildContext context ) async{
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("إلغاء"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget deleteButton = FlatButton(
    child: Text("DECLINE"),
    onPressed: () {
      for (var i = 0; i < allOrdersVendor.length; i++) {
        if(allOrdersVendor[i]['OrderId'] == completedId){
          allOrdersVendor[i]['completed'] = false;
          declinedList.add(allOrdersVendor[i]);
          allOrdersVendor.removeAt(i);
        }
      }
      Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (context) => Orders()),
      );
      Firestore.instance
      .collection('Vendors')
      .document(vendPhone)
      .updateData({'DeclinedOrders': declinedList});
      Firestore.instance
        .collection('Vendors')
        .document(vendPhone)
        .updateData({'Orders': allOrdersVendor});
     
      
      Navigator.of(context, rootNavigator: true).pop('dialog');
      (context as Element).reassemble();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("انتباه"),
    content: Text(
        "do you want to decline this order $finalPrice LBP" , style: TextStyle(fontSize: 15.0),),
    actions: [
      cancelButton,
      deleteButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

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
                       Text("Address : ${allShoppers[numberOfOrderSelected]['shopperAddress']}")),
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
                    _myFinalPriceInteger = 0;
                    
                    var mytempPrice = 0;
                    for (var i = 0; i < snapshot.data['Orders'][numberOfOrderSelected]['Products'].length; i++) {
                       var newProduct = {
                          'name': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['name'],
                          'finalPrice': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['finalPrice'],
                          'originalPrice': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['originalPrice'],
                          'value': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['value'],
                          'image': snapshot.data['Orders'][numberOfOrderSelected]['Products'][i]['image'],
                          
                        };
                        completedId = snapshot.data['Orders'][numberOfOrderSelected]['OrderId'];
                        
                        var exist = false;
                        for(var j = 0 ; j < myProductsListOrders.length ; j++){
                          if(newProduct['name'] == myProductsListOrders[j]['name']){
                            exist = true;
                          }  
                        }
                        if(exist == false){ 
                          myProductsListOrders.add(newProduct);
                          
                            mytempPrice += newProduct['finalPrice'];  
                          
                          
                          
                        }}
                    
                    
                    
                      _myFinalPriceInteger = mytempPrice;  
                    
                    
                    
                    

                  }}
                return NewListingOrders();
              }),
              new StreamBuilder(
                stream: Firestore.instance
                    .collection('Vendors')
                    .document(vendPhone)
                    .snapshots(),
                builder: (context, snapshot) {
                  allOrdersVendor.removeRange(0, allOrdersVendor.length);
                  if (!snapshot.hasData)
                    return Center(child: Text('No data in DB '));
                  else {
                    if (snapshot.data['Orders'].length == 0) {
                      return Center(
                          child: Text(
                        "Place your order",
                        style: TextStyle(color: Colors.transparent),
                      ));
                    } else {
                      for (var i = 0; i < snapshot.data['Orders'].length ; i++) {
                        var newShopperInfo ={
                        'phone':  snapshot.data['Orders'][i]['Pinfo']['phone'],
                        'id':snapshot.data['Orders'][i]['OrderId']
                        };
                        var exist = false;
                        for(var j = 0 ; j <  allOrdersVendor.length ; j++){
                          
                          if( newShopperInfo['id'] == allOrdersVendor[j]['OrderId']){
                            exist = true;
                          }
                          
                        }
                        if(exist == false){
                          allOrdersVendor.add(snapshot.data['Orders'][i]);
                        }
                      }
                      
                      print("allOrder at first : $allOrdersVendor");
                      
                    }
                  }
                  return Text("done",
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: 2.0,
                      ));
                }),
                new Row (
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: FlatButton(
                  child: Text("decline"),
                  onPressed: () {
                    setState(() {
                      
                      finalPrice = _myFinalPriceInteger;
                      _declineAlertDialog(context);
                      print('decline');
                    });
                  },
                ),
              ),
              Container(
                
                width: MediaQuery.of(context).size.width * 0.5,
                child: FlatButton(
                  
                  child:
                  Text("Accept"),
                  
                  onPressed: () {
                    setState(() {
                      
                      finalPrice = _myFinalPriceInteger;
                      _showAlertDialog(context);
                      
                    });
                  },
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
      child: new ListView(
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
                  Text("original price : ${myProductsListOrders[index]['originalPrice']}"),
                  Text("final price : ${myProductsListOrders[index]['finalPrice']}"),
                  Text("value : ${myProductsListOrders[index]['value']}"),
                    
                ],
              ),
            ],
          );
          
        }),
        
      ),
      
    );
    
  }
}
