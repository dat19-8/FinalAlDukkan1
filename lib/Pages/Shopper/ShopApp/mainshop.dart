import 'package:flutter/material.dart';
import './cart.dart';
import './favorite.dart';
import './memory.dart';
import './shopapp.dart';
import '../available.dart';

class MainShop extends StatefulWidget {
  final String pageTitle;

  MainShop({Key key, this.pageTitle}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<MainShop> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      ShopApp(),
      Cart(),
      Fav(),
      MemoryTab(context),
    ];
    return Scaffold(
        backgroundColor: Color.fromRGBO(15, 76, 117, 100),
        appBar: AppBar(

          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AvailableShopsPage()),
                      );
            },
            iconSize: 21,
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Color.fromRGBO(27, 38, 44, 100),
          title: Text('الدكان',style: TextStyle(color: Colors.white , fontSize: 30.0),),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
              onTap: () {},
              child: Icon( Icons.search, size: 26.0,),
              )
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                    Icons.settings
                ),
              )
            ),
          ],
        ),
        body: _tabs[_selectedIndex],
        //bottom tabs
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.store),
                title: Text(
                  'Store',
                  
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text(
                  'My Cart',
                  
                )
                
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text(
                  'Favourites',
                  
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text(
                  'Memory',
                  
                )),
            
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Color.fromRGBO(27, 38, 44, 100),
          type: BottomNavigationBarType.shifting,
          unselectedItemColor:  Color.fromRGBO(50, 130, 184,100),
          selectedItemColor:  Color.fromRGBO(27, 38, 44, 100),
          onTap: _onItemTapped,
        )
        );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}