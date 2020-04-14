import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaldukkan1/globals.dart';




final List<Map> tempFav = new List();
final List<Map> newMapCart = new List();


var selectedVendorInfo ;

class ShopApp extends StatefulWidget {
  @override
  _ShopAppState createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('Vendors')
              .document(selectedShopPhone)
              .snapshots(),
          builder: (context, snapshot) {
            
            
            if (!snapshot.hasData){
              return new CircularProgressIndicator();
              
            }

            else {
              if (snapshot.data['Products'].length == 0) {
                return Center(child: Text("This shop is empty"));
              } 
              
              else {
                
                var newVendor = {
                    'name': snapshot.data['Pinfo']['name'],
                    'address': snapshot.data['Pinfo']['address'],
                    

                };
                selectedVendorInfo = newVendor;
                for (var i = 0; i < snapshot.data['Products'].length; i++) {
                  
                  var newProduct1 = new Product(
                    snapshot.data['Products'][i]['name'],
                    int.parse(snapshot.data['Products'][i]['price']),
                    snapshot.data['Products'][i]['image'],
                    snapshot.data['Products'][i]['cart'],
                    snapshot.data['Products'][i]['favorite'],
                    snapshot.data['Products'][i]['value'],
                    snapshot.data['Products'][i]['available'],
                  );
                  var exist = false;
                      for (var j = 0; j < allProductsList.length; j++) {
                        if (newProduct1.image ==
                            allProductsList[j].image.toString()) {
                          exist = true;
                        }
                        if(exist == true && newProduct1.name != "name"){
                          allProductsList.removeAt(j);
                          exist = false;
                        }
                      }
                      if (exist == false) {
                        allProductsList.add(newProduct1);
                      }
                }
              }
            }
            print(allProductsList);
            return ProductListing();
          }
    )); }

  }


class ProductListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.81,
      child: new GridView.count(
        crossAxisCount: 2,
        children: List.generate(allProductsList.length, (index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 100.0,
                  child: FlatButton(
                    onPressed: () {
                      
                      allProductsList[index].cart = true;
                      var exist = false;
                      for (var i = 0; i < myCart.length; i++) {
                        if (allProductsList[index].name == myCart[i].name) {
                          allProductsList[index].value = allProductsList[index].value + 1;
                          exist = true;
                        }
                      }
                      if (exist == false) {
                        myCart.add(allProductsList[index]);
                      }
                      var changeMyCartProducts = {
                                'name':myCart[index].name,
                                'price':myCart[index].price,
                                'available':myCart[index].available,
                                'image':myCart[index].image,
                                'cart':myCart[index].cart,
                                'favorite':myCart[index].favorite,
                                'value':myCart[index].value

                              };
                      newMapCart.add(changeMyCartProducts);
                      print(newMapCart);
                    },
                    child: Image.network(allProductsList[index].image),
                    
                  )),
              
              FlatButton(
                onPressed:() {
                  
                  
                  var newTemp={
                    'name':allProductsList[index].name,
                    'price':allProductsList[index].price,
                    'cart' :allProductsList[index].cart,
                    'favorite': false,
                    'image':allProductsList[index].image,
                    'value': allProductsList[index].value,
                    "available":allProductsList[index].available


                  };
                  
                  if(allProductsList[index].favorite == true)
                  { 
                    
                    if(tempFav.length == 1){
                      print("removed ${tempFav[0]}" );
                      tempFav.removeAt(0);
                    }
                    for(var i = 0 ; i < tempFav.length ; i++){
                      if(allProductsList[index].name == tempFav[i]['name']){
                        newTemp['favorite']=false;
                        allProductsList[index].favorite = false;
                        tempFav.removeAt(i);
                        
                      }
                    }  
                    Firestore.instance.collection('Shoppers').document(shopPhone).updateData({selectedShopPhone.toString() : tempFav});
                    allProductsList[index].favorite = false;
                    
                  }
                  else{
                    allProductsList[index].favorite = true;
                    newTemp['favorite']=true;
                    tempFav.add(newTemp);
                    
                    Firestore.instance.collection('Shoppers').document(shopPhone).updateData({selectedShopPhone.toString() : tempFav});
                    (context as Element).reassemble();
                    }
                },
                child   : allProductsList[index].favorite ==  true ? Icon(Icons.favorite , color: Colors.red,):Icon(Icons.favorite_border),
                
              ),
              
              Text("name : ${allProductsList[index].name}"),
              Text("price : ${allProductsList[index].price}"),
            ],
          );
        }),
      ),
    );
  }
}