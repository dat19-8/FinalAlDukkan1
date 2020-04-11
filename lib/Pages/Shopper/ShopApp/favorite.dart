import 'package:flutter/material.dart';
import './shopapp.dart';
import 'package:finaldukkan1/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

List<Product> myFav = new List();

class _FavState extends State<Fav> {
  bool ccomplete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Shoppers')
                .document(shopPhone)
                .snapshots(),
            builder: (context, snapshot) {
              
              print("complete = false");
              if(tempFav.length != 0 ) {
                ccomplete = true;
              }
              if (ccomplete == false) return Center(child: new Text("You have no favorites" , style: TextStyle(color: Colors.blueGrey , fontSize: 20.0),));
              if (!snapshot.hasData )
                return Center(child: Text('No data in DB '));
              
              if(ccomplete == true){
                print("complete = true");
                if (snapshot.data[selectedShopPhone].length == 0) {
                  return Center(child: Text("You have no favorites" , style: TextStyle(color: Colors.blueGrey , fontSize: 20.0),));
                } else {
                  myFav.removeRange(0, myFav.length);
                  for (var i = 0;
                      i < snapshot.data[selectedShopPhone].length;
                      i++) {
                    var newFav1 = new Product(
                      snapshot.data[selectedShopPhone][i]['name'],
                      snapshot.data[selectedShopPhone][i]['price'],
                      snapshot.data[selectedShopPhone][i]['image'],
                      snapshot.data[selectedShopPhone][i]['cart'],
                      snapshot.data[selectedShopPhone][i]['favorite'],
                      snapshot.data[selectedShopPhone][i]['value'],
                      snapshot.data[selectedShopPhone][i]['available'],
                    );
                    var exist = false;

                    for (var j = 0; j < myFav.length; j++) {
                      if (newFav1.name.toString() == myFav[j].name.toString()) {
                        if (snapshot.data[selectedShopPhone][i]['favorite'] ==
                            false) {
                          myFav.remove(snapshot.data[selectedShopPhone][i]);
                        }
                      }
                    }
                    if (exist == false &&
                        snapshot.data[selectedShopPhone][i]['favorite'] ==
                            true) {
                      myFav.add(newFav1);
                    }
                  }
                }
              }
              return NewProductListing();
            }));
  }
}

class NewProductListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new GridView.count(
        crossAxisCount: 2,
        children: List.generate(myFav.length, (index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 145.0,
                  child: FlatButton(
                    onPressed: () {
                      print('increment/decrement value ');
                    },
                    child: Image.network(myFav[index].image),
                  )),
              Text("name : ${myFav[index].name}"),
              Text("address : ${myFav[index].price}"),
            ],
          );
        }),
      ),
    );
  }
}
