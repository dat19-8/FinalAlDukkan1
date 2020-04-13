
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaldukkan1/globals.dart';
import './vendapp.dart';


class ModifyItemsDB extends StatelessWidget {
  final TextEditingController _nameController1 = new TextEditingController();
  final TextEditingController _priceController1 = new TextEditingController();
  final List<Map> myModifyProducts =  List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 38, 44, 100),
        title: Center(
          child: Text(
            'الدكان',
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          ),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(
            
            padding: EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.width * 0.20,
            child: TextFormField(
              
              controller: _nameController1,
              cursorColor: Colors.white,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefix: Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "name",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              autovalidate: true,
              autocorrect: false,
              maxLengthEnforced: true,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.width * 0.20,
            child: TextFormField(
              controller: _priceController1,
              cursorColor: Colors.white,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefix: Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "price",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              autovalidate: false,
              autocorrect: false,
              maxLengthEnforced: false,
            ),
          ),
          StreamBuilder(
              stream: Firestore.instance
                  .collection('Vendors')
                  .document(vendPhone)
                  .snapshots(),
              builder: (context, snapshot) {
                
                if (snapshot.data['Products'].length != 0) {
                  for (var i = 0; i < snapshot.data['Products'].length; i++) {
                    myModifyProducts.add(snapshot.data['Products'][i]); 
                  }  
                }

                return Text("done");
              }),
            FlatButton(
              onPressed: () {
                for(var i = 1 ; i <= myModifyProducts.length -1;i++ ){
                      
                  if(myModifyProducts[i]['image'] == chosenImageUrl)   {
                    myModifyProducts.removeAt(i);

                  }
                }
                var finalName;
                var finalPrice;
                if(_nameController1.text == ""){
                  finalName = "name";
                }
                else{
                  finalName = _nameController1.text;
                }
                if(_priceController1.text == ""){
                  finalPrice = "0";
                }
                else{
                  finalPrice=  _priceController1.text;
                }
                
                var newProduct1 = {
                  'image': chosenImageUrl,
                  'name': finalName,
                  'price': finalPrice,
                  'cart': false,
                  'available': true,
                  'favorite': false,
                  'value': 1
                };
                myModifyProducts.add(newProduct1);
                for(var i = 0 ; i < myModifyProducts.length -2; i++){
                
                    for(var j = 1 ; j <= myModifyProducts.length -1;j++ ){
                      
                      if(myModifyProducts[i]['image'] == myModifyProducts[j]['image']  )   {
                        myModifyProducts.removeAt(i);

                      }
                    }
                }
                
                
                
                Firestore.instance
                    .collection('Vendors')
                    .document(vendPhone).updateData({'Products': myModifyProducts});
                
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => Vendapp()));
              },
              child: Text("Add"))
        ]),
      ),
    );
  }
}
