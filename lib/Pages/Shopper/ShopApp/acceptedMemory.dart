import 'package:flutter/material.dart';
import 'package:finaldukkan1/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool completed = false;


class Memory extends StatefulWidget {
  @override
  _MemoryState createState() => _MemoryState();
}
final List<Map> allProductsListMemory = new List();
_cartDialogue(BuildContext context, index ) async{
  // set up the buttons
  print('object');
  Widget noButton = FlatButton(
    child: Text("NO"),
    onPressed: () {
      
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget yesButton = FlatButton(
    child: Text("YES"),
    onPressed: () {

      var exist = false;
    if(myCart.length == 0){
      
      
      var changeMyCartProducts = {
        'name':allProductsListMemory[index]['name'],
        'price':allProductsListMemory[index]['Originalprice'],
        'available':allProductsListMemory[index]['available'],
        'image':allProductsListMemory[index]['image'],
        'value':allProductsListMemory[index]['value']
      };
        myCart.add(changeMyCartProducts);
    }
    else{
      
      for (var i = 0; i < myCart.length; i++) {
        if (allProductsListMemory[index]['name'] == myCart[i]['name']) {
          exist = true;
        }
      }
      if (exist == false) {
        
        var changeMyCartProducts = {
              
              'name':allProductsListMemory[index]['name'],
              'price':allProductsListMemory[index]['Originalprice'],
              'available':allProductsListMemory[index]['available'],
              'image':allProductsListMemory[index]['image'],
              'cart':allProductsListMemory[index]['cart'],
              'favorite':allProductsListMemory[index]['favorite'],
              'value':allProductsListMemory[index]['value']

            };
        
        myCart.add(changeMyCartProducts);
        
      }
    }
    for (var i = 0; i < myCart.length; i++) {
        
      if(allProductsListMemory[index]['image'] == myCart[i]['image']){
        
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
          if( allProductsListMemory[index]['image'] == myCartPricesList[i]['image']){
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
            if(allProductsListMemory[index]['image'] == myCartValuesList[i]['image']){
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
        "do you want to add this Item to your Cart " , style: TextStyle(fontSize: 15.0),),
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
class _MemoryState extends State<Memory> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(27, 38, 44, 100),
          title: Center(
            child: Text(
              'الدكان',
              style: TextStyle(color: Colors.white, fontSize: 50.0),
            ),
          ),
        ),
    backgroundColor: Colors.white,
    body: Column(
    children: <Widget>[
      StreamBuilder(
          stream: Firestore.instance
              .collection('Vendors')
              .document(selectedShopPhone)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text('No data in DB '));
            else {
              if(statusOrdersList[numbOfOrderSelectedShopper] == true){
                if (snapshot.data['CompletedOrders'].length >= 0) {
                
                allProductsListMemory.removeRange(0, allProductsListMemory.length);

                for(var i = 0 ; i < snapshot.data['CompletedOrders'].length ; i++){
                  print('yes');
                  if(idOrderslist[numbOfOrderSelectedShopper] == snapshot.data['CompletedOrders'][i]['OrderId']){
                    print('yes yes');
                    var tempPrice = 0;
                    completed = snapshot.data['CompletedOrders'][numbOfOrderSelectedShopper]['completed'];
                    print('yes yes .11');
                    for (var j = 0; j < snapshot.data['CompletedOrders'][i]['Products'].length; j++) {
                      print('yes yes yes');
                      var newProduct1 ={
                        'name': snapshot.data['CompletedOrders'][i]['Products'][j]['name'],
                        'Originalprice':snapshot.data['CompletedOrders'][i]['Products'][j]['originalPrice'],
                        'image':snapshot.data['CompletedOrders'][i]['Products'][j]['image'],
                        'value': snapshot.data['CompletedOrders'][i]['Products'][j]['value'],
                        'finalPrice':snapshot.data['CompletedOrders'][i]['Products'][j]['finalPrice'],
                      };
                      print(newProduct1);
                      var exist = false;
                      for (var k = 0; k < allProductsListMemory.length; k++) {
                        if (newProduct1['image'] == allProductsListMemory[k]['image'].toString()) {
                          exist = true;
                        }
                      }
                      if (exist == false) {
                        tempPrice += newProduct1['finalPrice'];
                        allProductsListMemory.add(newProduct1);
                      }
                    }
                      myFinalPriceInteger = tempPrice;
                    
                  }
                }
              }
              }
              
              if(statusOrdersList[numbOfOrderSelectedShopper] == false){
              
              if (snapshot.data['DeclinedOrders'].length >= 0) {
                allProductsListMemory.removeRange(0, allProductsListMemory.length);
                var counter = 0 ;
                
                for(var i = 0 ; i < statusOrdersList.length ; i++ ){
                  if(statusOrdersList[i] == true && i < numbOfOrderSelectedShopper){
                    counter = counter + 1;
                  }

                }
                print("counter:$counter");
                var useSelectedPhone = numbOfOrderSelectedShopper;
                print("useSelectedPhone :$useSelectedPhone");
                numbOfOrderSelectedShopper -= counter;
                print("numbOfOrderSelectedShopper :$numbOfOrderSelectedShopper");
                for(var i = 0 ; i < snapshot.data['DeclinedOrders'].length ; i++){
                  print('no');
                  // numbOfOrderSelectedShopper +=counter;
                  if(idOrderslist[useSelectedPhone] == snapshot.data['DeclinedOrders'][i]['OrderId']){
                    
                    print('no no');
                    var tempPrice = 0;
                    
                    completed = snapshot.data['DeclinedOrders'][numbOfOrderSelectedShopper]['completed'];
                    (context as Element).reassemble();

                    for (var j = 0; j < snapshot.data['DeclinedOrders'][i]['Products'].length; j++) {
                      print('no no no');
                      var newProduct1 ={
                        'name': snapshot.data['DeclinedOrders'][i]['Products'][j]['name'],
                        'Originalprice':snapshot.data['DeclinedOrders'][i]['Products'][j]['originalPrice'],
                        'image':snapshot.data['DeclinedOrders'][i]['Products'][j]['image'],
                        'value': snapshot.data['DeclinedOrders'][i]['Products'][j]['value'],
                        'finalPrice':snapshot.data['DeclinedOrders'][i]['Products'][j]['finalPrice'],
                      };
                      print(newProduct1);
                      var exist = false;
                      for (var k = 0; k < allProductsListMemory.length; k++) {
                        if (newProduct1['image'] == allProductsListMemory[k]['image'].toString()) {
                          exist = true;
                        }
                      }
                      if (exist == false) {
                        tempPrice += newProduct1['finalPrice'];
                        allProductsListMemory.add(newProduct1);
                      }
                    }
                      myFinalPriceInteger = tempPrice;
                    
                  }
                }
              }
              }
            }
            print('allProductsListMemory $allProductsListMemory');
            // return Text("here");
            return NewMemoryProductListing();
        }),
        new Row(
          children: <Widget>[
            Container( width: MediaQuery.of(context).size.width * 1 ,child: Center(child: Text('Order Price:  $myFinalPriceInteger')))
          ],
        ),
        new Row(
          children: <Widget>[
            statusOrdersList[numbOfOrderSelectedShopper] == true ? Container( width: MediaQuery.of(context).size.width * 1 ,child: Center(child: Text('Order Status: Accepted'))) :Container( width: MediaQuery.of(context).size.width * 1 ,child: Center(child: Text('Order Status: Declined')))
            
          ],
        )
      ],
    ),
  );

  }
}


class NewMemoryProductListing extends StatefulWidget {
  @override
  _NewMemoryProductListingState createState() => _NewMemoryProductListingState();
}


class _NewMemoryProductListingState extends State<NewMemoryProductListing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.81,
      child: new ListView(
        semanticChildCount: 1,
        
        children: List.generate(allProductsListMemory.length, (index) {
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
                    child:FlatButton(
                      onPressed:() {
                        setState(() {
                          print('hello');
                          _cartDialogue(context, index);
                          
                        });
                      } ,
                      child: Image.network(allProductsListMemory[index]['image']),)
                     
                  ),
                ],
              ),
                  
              Column(
                children: <Widget>[
                  
                  Text("name : ${allProductsListMemory[index]['name']}"),
                  Text("original price : ${allProductsListMemory[index]['Originalprice']}"),
                  Text("final price : ${allProductsListMemory[index]['finalPrice']}"),
                  Text("value : ${allProductsListMemory[index]['value']}"),
                    
                ],
              ),
            ],
          );
          
        }),
      ),
    );
  }
}