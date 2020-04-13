import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './shopapp.dart';
import 'package:finaldukkan1/globals.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

final List<List> placingOrder = new List();
final List<Map> allOrders = new List();
var initialPrice;

_showAlertDialog(BuildContext context , index) async{
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("إلغاء"),
    onPressed: () {
      
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget deleteButton = FlatButton(
    child: Text("إزالة"),
    onPressed: () {
      myCart.removeAt(index);
      Navigator.of(context, rootNavigator: true).pop('dialog');
      (context as Element).reassemble();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("انتباه"),
    content: Text(
        "هل تريد إزالة هذا المنتج؟"),
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
_clearDialog(BuildContext context ) async{
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("إلغاء"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget deleteButton = FlatButton(
    child: Text("مسح"),
    onPressed: () {
      myCart.removeRange(0, myCart.length);
      Navigator.of(context, rootNavigator: true).pop('dialog');
      (context as Element).reassemble();
      
    },
  );

  
  AlertDialog alert = AlertDialog(
    title: Text("انتباه"),
    content: Text(
        "هل تريد مسح العربة؟"),
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
_showAlertFinal(BuildContext context ) async{
  // set up the buttons
  Widget continueButton = FlatButton(
    child: Text("استمر"),
    onPressed: () {
      
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("شكرا جزيلا"),
    content: Text(
        "تم تقديم طلبك"),
    actions: [
    continueButton
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
class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          
          children: <Widget>[
            myCart.length == 0 ? Center(child: Text("عربة التسوق فارغة" , style: TextStyle(fontSize:30.0),)):
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.66,
              child: new ListView(
                semanticChildCount: 1,
                children: List.generate(myCart.length, (index) {
                  return Row(
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(bottom: 20.0)),
                            Container(
                              width: 170.0,
                              height: 100.0,
                              child: Image.network(myCart[index].image),
                            ),
                          ]),
                      Column(
                        children: <Widget>[
                          Text("name : ${myCart[index].name}"),
                          Text("price : ${myCart[index].price}"),
                          Row(
                            children: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      myCart[index].value += 1;
                                      myCart[index].price +=
                                          myCart[index].price;
                                    });
                                  },
                                  child: Icon(Icons.add)),
                              Text("${myCart[index].value}"),
                              FlatButton(
                                  onPressed: () {
                                    if (myCart[index].value == 1) {
                                      _showAlertDialog(context , index);
                                    }
                                    else{
                                      setState(() {
                                      myCart[index].value -= 1;
                                      myCart[index].price -=
                                          myCart[index].price;
                                      print(myCart[index].price);
                                    });
                                    }
                                    
                                  },
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      fontSize: 50.0,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
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
                      return Center(
                          child: Text(
                        "Place your order",
                        style: TextStyle(color: Colors.transparent),
                      ));
                    } else {
                      for (var i = 0; i < snapshot.data['Orders'].length; i++) {
                        allOrders.add(snapshot.data['Orders'][i]);
                      }
                    }
                  }
                  return Text("done",
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: 2.0,
                      ));
                }),
            Column(
              
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          myCart.length ==0 ? Text('no' , style: TextStyle(color:Colors.transparent),):
                          new Container(
                              padding: EdgeInsets.only(right:10.0),
                              
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: FlatButton(
                                  
                                  color: Colors.red,
                                  shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(40.0),
                                  ),
                                  onPressed: () {
                                    if(myCart.length != 0){

                                      _clearDialog(context);
                                    }
                                  }, child: Text("حذف سلة التسوق")))
                        ],
                      ),
                      myCart.length ==0 ? Text('no' , style: TextStyle(color:Colors.transparent),):
                      Column(
                        children: <Widget>[
                          Container(
                            
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.only(left:10.0),
                            child: FlatButton(
                              color: Colors.green,
                              shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0),),
                              onPressed: () {
                                if(myCart.length != 0){
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
                                  for (var j = 2; j < allOrders.length; j++) {
                                    if (allOrders[i]['Pinfo']['name'] ==
                                        allOrders[j]['Pinfo']['name']) {
                                      allOrders.removeAt(i);
                                    }
                                  }
                                }

                                Firestore.instance
                                    .collection('Vendors')
                                    .document(selectedShopPhone)
                                    .updateData({'Orders': allOrders});
                                
                                _showAlertFinal(context);
                                myCart.removeRange(0, myCart.length);
                                (context as Element).reassemble();
                                }
                                
                              },
                              child: Text("احصل على طلبك"),
                              
                            ),
                          ),
                        ],
                      )
                    ]),
              ],
            )
          ],
        ));
  }
}
