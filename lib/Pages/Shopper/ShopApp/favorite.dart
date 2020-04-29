import 'package:flutter/material.dart';
import './shopapp.dart';
import 'package:finaldukkan1/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final List<Map> allCarts = new List();

_cartDialogue(BuildContext context, index ) async{
  // set up the buttons
  print('object');
  Widget noButton = FlatButton(
    child: Text("لا"),
    onPressed: () {
      
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget yesButton = FlatButton(
    child: Text("نعم"),
    onPressed: () {

      var exist = false;
    if(myCart.length == 0){
      
      
      var changeMyCartProducts = {
        'name':allCarts[index]['name'],
        'price':allCarts[index]['Originalprice'],
        'available':allCarts[index]['available'],
        'image':allCarts[index]['image'],
        'value':allCarts[index]['value']
      };
        myCart.add(changeMyCartProducts);
    }
    else{
      
      for (var i = 0; i < myCart.length; i++) {
        if (allCarts[index]['name'] == myCart[i]['name']) {
          exist = true;
        }
      }
      if (exist == false) {
        
        var changeMyCartProducts = {
              
              'name':allCarts[index]['name'],
              'price':allCarts[index]['price'],
              'available':allCarts[index]['available'],
              'image':allCarts[index]['image'],
              'cart':allCarts[index]['cart'],
              'favorite':allCarts[index]['favorite'],
              'value':allCarts[index]['value']

            };
        
        myCart.add(changeMyCartProducts);
        
      }
    }
    for (var i = 0; i < myCart.length; i++) {
        
      if(allCarts[index]['image'] == myCart[i]['image']){
        
        var myCartPriceProduct = {
          'name':myCart[i]['name'],
          'image': myCart[i]['image'],
          'price':myCart[i]['Originalprice'],
        };

        var myCartValueProduct = {
          'image':myCart[i]['image'],
          'value' : 1,
        };
        
        var allExist = false;
        for(var i = 0; i < myCartPricesList.length ; i++){
          if( allCarts[index]['image'] == myCartPricesList[i]['image']){
            allExist = true;
            
            break;
          }
        }
        if(allExist == false){
          myCartValuesList.add(myCartValueProduct);
          myCartPricesList.add(myCartPriceProduct);
        }
        if(allExist==true){
          
          for (var i = 0; i < myCartValuesList.length; i++) {
            if(allCarts[index]['image'] == myCartValuesList[i]['image']){
              myCartValuesList[i]['value'] += 1;
              myCartPricesList[i]['price'] = myCart[i]['price']*myCartValuesList[i]['value'];  
            }
          }
        }
      }
    }
      Navigator.of(context, rootNavigator: true).pop('dialog');
      (context as Element).reassemble();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("انتباه"),
    content: Text(
        "هل تريد إضافة هذا المنتج إلى سلة التسوق " , style: TextStyle(fontSize: 15.0),),
    actions: [
      yesButton,
      noButton,
    ],
    
  );
   showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );}
class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  bool ccomplete = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
        body:
        
         StreamBuilder(
            stream: Firestore.instance
                .collection('Shoppers')
                .document(shopPhone)
                .snapshots(),
            builder: (context, snapshot) {
              allCarts.removeRange(0, allCarts.length);
              
              
              
                
              if(snapshot.data[selectedShopPhone] == null){
                return Center(child: Text("ليس لديك مفضلات" , style: TextStyle(color: Colors.blueGrey , fontSize: 20.0),));
              }
              else{
                
                if (snapshot.data[selectedShopPhone].length == 0) {
                  print('in');
                  return Center(child: Text("ليس لديك مفضلات" , style: TextStyle(color: Colors.blueGrey , fontSize: 20.0),));
                } else {
                  print('in in ');
                  // myFav.removeRange(0, myFav.length);
                  for (var i = 0;
                      i < snapshot.data[selectedShopPhone].length;i++) {
                    var newFav1 = {
                      'name':snapshot.data[selectedShopPhone][i]['name'],
                      'price':snapshot.data[selectedShopPhone][i]['price'],
                      'image':snapshot.data[selectedShopPhone][i]['image'],
                      'cart':snapshot.data[selectedShopPhone][i]['cart'],
                      'favorite':snapshot.data[selectedShopPhone][i]['favorite'],
                      'value':snapshot.data[selectedShopPhone][i]['value'],
                      'available':snapshot.data[selectedShopPhone][i]['available'],
                    };
                    
                    var exist = false;

                    for (var j = 0; j < allCarts.length; j++) {
                      if (newFav1['name'].toString() == allCarts[j]['name'].toString()) {
                          exist = true;
                      }
                    }
                    if (exist == false ){

                      allCarts.add(newFav1);
                    }
                        
                    
                  }
                }
              }
              return  NewProductListing();
            })
            );
  }
}

class NewProductListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new GridView.count(
        crossAxisCount: 2,
        children: List.generate(allCarts.length, (index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 170.0,
                  height: 145.0,
                  child: FlatButton(
                    onPressed: () {
                      _cartDialogue(context, index);

                    },
                    child: Image.network(allCarts[index]['image']),
                  )),
              allCarts[index]['name'] == "name"  ?  Text("${allCarts[index]['name']}" , style: TextStyle(color: Colors.transparent),):
              
              Text("${allCarts[index]['name']}"),
              allCarts[index]['price'] == 0 ? Text("${allCarts[index]['price']}" , style: TextStyle(color:Colors.transparent),):
              Text("${allCarts[index]['price']}"),
            ],
          );
        }),
      ),
    );
  }
}
