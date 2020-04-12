import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './modifyItems.dart';
import './vendcam.dart';
import 'package:finaldukkan1/globals.dart';

final List<Product> myProductsList = new List();
final TextEditingController _nameController1 = new TextEditingController();
final TextEditingController _priceController1 = new TextEditingController();

class Vendapp extends StatefulWidget {
  @override
  _VendappState createState() => _VendappState();
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
          // print("index" + "${index}");
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 148.0,
                  // child: Image.memory(base64.decode(base64ImageUrl)),

                  child: FlatButton(
                    child: Image.network(myProductsList[index].image),
                    onPressed: () {
                      print('modify');
                      indexchosen = index;
                      print("indexchosen: ${index}");
                      chosenImageUrl = myProductsList[index].image;
                      print("chosenImageUrl: ${myProductsList[index].image}");
                      
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ModifyItemsDB()),
                        );
                      
                    },
                  )),
              Text("${myProductsList[index].name}"),
              Text("${myProductsList[index].price}"),
            ],
          );
        }),
      ),
    );
  }
}
