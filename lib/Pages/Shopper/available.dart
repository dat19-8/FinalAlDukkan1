import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaldukkan1/globals.dart';
import '../Shopper/ShopApp/mainshop.dart';

final List<Shop> myShopsList = new List();

class AvailableShopsPage extends StatefulWidget {
  @override
  _AvailableShopsPageState createState() => _AvailableShopsPageState();
}

class _AvailableShopsPageState extends State<AvailableShopsPage> {
  bool _loadingInProgress;

  @override
  void initState() {
    super.initState();
    _loadingInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(27, 38, 44, 100),
          title: Center(
            child: Text(
              'الدكان',
              style: TextStyle(color: Colors.white, fontSize: 50.0),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('Vendors').snapshots(),
            builder: (context, snapshot) {
              myShopsList.removeRange(0, myShopsList.length);
              if (_loadingInProgress == false && !snapshot.hasData) {
                return Center(child: new CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                _loadingInProgress = true;

                for (var i = 0; i < snapshot.data.documents.length; i++) {
                  vendorslist.add(snapshot.data.documents[i]['phonenumber']);
                  if (snapshot.data.documents[i]['Pinfo'] != null) {
                    var newShop = Shop(
                        snapshot.data.documents[i]['Pinfo']['name'],
                        snapshot.data.documents[i]['Pinfo']['image'],
                        snapshot.data.documents[i]['Pinfo']['address'],
                        snapshot.data.documents[i]['phonenumber']);
                    var exist = false;

                    if (exist == false) {
                      myShopsList.add(newShop);
                    }
                  }
                }
              }
              return NewProductList();
            }),
      ),
    );
  }
}

class NewProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new GridView.count(
        crossAxisCount: 2,
        children: List.generate(myShopsList.length, (index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 145.0,  
                  child: FlatButton(
                    onPressed: () {
                      allProductsList.removeRange(0, allProductsList.length);
                      selectedShopPhone = '';
                      print('go to shop');
                      selectedShopPhone = myShopsList[index].phone.toString();
                      myCart.removeRange(0, myCart.length);
                      print("selectedShopPhone :${selectedShopPhone}");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainShop()),
                      );
                    },
                    child: Image.network(myShopsList[index].image),
                  )),
              Text("${myShopsList[index].name}"),
              Text(" ${myShopsList[index].phone}"),
            ],
          );
        }),
      ),
    );
  }
}
