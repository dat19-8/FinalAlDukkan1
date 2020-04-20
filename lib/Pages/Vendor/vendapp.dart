import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './modifyItems.dart';
import './vendcam.dart';
import 'package:finaldukkan1/globals.dart';

final List<Product> myProductsList = new List();
final List<Product> newProductList = new List();

class Vendapp extends StatefulWidget {
  @override
  _VendappState createState() => _VendappState();
}

_alertDialog(BuildContext context ) async{
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("إلغاء"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget modifyButton = FlatButton(
    child: Text("modify"),
    onPressed: () {
      print("modify this item");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ModifyItemsDB()),
      );        
      Navigator.of(context, rootNavigator: true).pop('dialog');
      
    },
  );
  Widget deleteButton = FlatButton(
    child: Text("delete item"),
    onPressed: () {
      myCart.removeRange(0, myCart.length);
      myCartPricesList.removeRange(0, myCartPricesList.length);
      myCartValuesList.removeRange(0, myCartValuesList.length);
      Navigator.of(context, rootNavigator: true).pop('dialog');
      (context as Element).reassemble();
      
    },
  );

  
  AlertDialog alert = AlertDialog(
    title: Text("انتباه"),
    content: Text(
        "Delete ot Modify item?"),
    actions: [
      cancelButton,
      deleteButton,
      modifyButton
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
class _VendappState extends State<Vendapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraTab()),
                  );
                },
                child: Icon(
                  Icons.camera_alt,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  print("delete");
                },
                child: Icon(
                  Icons.edit,
                  size: 26.0,
                ),
              )),
        ],
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
                  if (snapshot.data['Products'].length == 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Text(
                          "You have no Products",
                          style: TextStyle(fontSize: 30.0),
                        )),
                      ],
                    );
                  } else {
                    for (var i = 0; i < snapshot.data['Products'].length; i++) {
                      var newProduct = Product(
                        snapshot.data['Products'][i]['name'],
                        int.parse(snapshot.data['Products'][i]['price']),
                        snapshot.data['Products'][i]['image'],
                        snapshot.data['Products'][i]['cart'],
                        snapshot.data['Products'][i]['favorite'],
                        snapshot.data['Products'][i]['value'],
                        snapshot.data['Products'][i]['available'],
                      );

                      var exist = false;
                      for (var j = 0; j < myProductsList.length; j++) {
                        if (newProduct.image ==
                            myProductsList[j].image.toString()) {
                          exist = true;
                        }
                        if(exist == true && newProduct.name != "name"){
                          myProductsList.removeAt(j);
                          exist = false;
                        }
                      }
                      if (exist == false) {
                        myProductsList.add(newProduct);
                      }
                    }
                  }
                }
                return NewListing();
              }),
        ],
      ),
    );
  }
}

class NewListing extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.785,
      child: new GridView.count(
        crossAxisCount: 2,
        children: List.generate(myProductsList.length, (index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 148.0,
                  child: FlatButton(
                    child: Image.network(myProductsList[index].image),
                    onPressed: () {
                      print('modify');
                      indexchosen = index;
                      print("indexchosen: ${index}");
                      chosenImageUrl = myProductsList[index].image;
                      print("chosenImageUrl: ${myProductsList[index].image}");
                      _alertDialog(context);
                      
                    },
                  )),
                
              myProductsList[index].name == "name"  ?  Text("${myProductsList[index].name}" , style: TextStyle(color: Colors.transparent),):
              
              Text("${myProductsList[index].name}"),


              myProductsList[index].price == 0 ? Text("${myProductsList[index].price}" , style: TextStyle(color:Colors.transparent),):
              Text("${myProductsList[index].price}"),


            ],
          );
        }),
      ),
    );
  }
}
