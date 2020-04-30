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
    child: Text("قبول"),
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
        "هل تريد قبول هذا الطلب $finalPrice ل.ل." , style: TextStyle(fontSize: 15.0),),
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
    child: Text("رفض"),
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
        "هل تريد إلغاء هذا الطلب $finalPriceل.ل." , style: TextStyle(fontSize: 15.0),),
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
                          child: Text("الاسم : ${allShoppers[numberOfOrderSelected]['shopperName']}")),
                      Container(
                          width: 200.0,
                          height: 30.0,
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text("رقم الهاتف : ${allShoppers[numberOfOrderSelected]['shopperPhoneNumber']}")),
                      Container(
                          width: 200.0, height: 30.0, child:
                       Text("عنوان : ${allShoppers[numberOfOrderSelected]['shopperAddress']}")),
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
                    return Center(child: Text("لا توجد منتجات في قائمة الطلبات هذه"));
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
                        "قدّم الطلب",
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
    color:Colors.red,
                  child: Text("رفض"),

                  onPressed: () {
                    setState(() {
                      
                      finalPrice = _myFinalPriceInteger;
                      _declineAlertDialog(context);
                      
                    });
                  },
                ),
              ),
              Container(
                
                width: MediaQuery.of(context).size.width * 0.5,
                child: FlatButton(
    color:Colors.green
                  ,child:
                  Text("قبول"),

                  
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
                  
                  Text("اسم المنتج : ${myProductsListOrders[index]['name']}"),
                  Text("السعر الأصلي : ${myProductsListOrders[index]['originalPrice']}"),
                  Text("السعر النهائي : ${myProductsListOrders[index]['finalPrice']}"),
                  Text("القيمة : ${myProductsListOrders[index]['value']}"),
                    
                ],
              ),
            ],
          );
          
        }),
        
      ),
      
    );
    
  }
}
