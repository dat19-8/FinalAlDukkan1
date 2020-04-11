import 'package:flutter/material.dart';
import 'package:finaldukkan1/globals.dart';
import '../Shopper/available.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'shopmap.dart';


class SignUpShopper extends StatefulWidget {
  @override
  _SignUpShopper createState() => _SignUpShopper();
}
class _SignUpShopper extends State<SignUpShopper> {
  //to retrieve data from textfield
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
    
      appBar: AppBar(
        title: Text('المتسوق',style: TextStyle(color: Colors.white , fontSize: 30.0),),
        backgroundColor: Color.fromRGBO(27, 38, 44, 100), 
        
      ),
      backgroundColor: Color.fromRGBO(15, 76, 117, 100),
      body: 
         new Column(
          children: <Widget>[

            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(top: 80.0, left: 40.0),
                    child: new Text(
                      "اسم المستخدم",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 23.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.white,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      // obscureText: true,
                      style: TextStyle(
                        color: Colors.white
                      ),
                      textAlign: TextAlign.left,
                      controller: _nameController,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(187, 215, 250,100),
                        border: InputBorder.none,
                        hintText: 'الاسم الكامل',
                        hintStyle: TextStyle(color: Colors.grey ,fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "العنوان",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 23.0,
                      ),
                    ),
                  ),
                ),
              ],   
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.white,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      // obscureText: true,
                      style: TextStyle(
                        color: Colors.white
                      ),
                      textAlign: TextAlign.left,
                      controller:  _addressController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: ' ... اسم الشارع ، المبنى ',

                        hintStyle: TextStyle(color: Colors.grey , fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Container(
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(60.0),
                      ),
                      color: Color.fromRGBO(50, 130, 184,100),
                      onPressed: () {
                        print("maps");
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => GoogleMapp()),
                      // );
                      },
                      child: Icon(Icons.gps_fixed),
              ),
            ),
            
            Divider(
              height: 24.0,
            ),
            
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Color.fromRGBO(50, 130, 184,100),
                      child: new Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: Text(
                                "أفتح حساب ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0
                                    ),
                                    
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        if(_nameController.text.length == 0 && _addressController.text.length == 0 ){
                          Alert(context: context, title: 'أضف اسم المستخدم').show();
                        }
                        else{
                        var finalAddress;
                        if(_addressController.text ==""){
                          finalAddress = "";
                        }
                        else{
                          finalAddress = _addressController.text;
                        }
                        
                        shopperAddress = _addressController.text;
                        shopperName= _nameController.text;
                        
                        Firestore.instance.collection('Shoppers').document(tempPhone).updateData({'Pinfo':{'googleMaps':currentLocation.toString(),'name': _nameController.text, 'address' : finalAddress}});
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AvailableShopsPage()),
                        );
                        }

                      }
                        
                        
                      
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      
    );
  }
}

