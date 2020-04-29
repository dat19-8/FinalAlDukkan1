
import 'package:flutter/material.dart';
import './orders.dart';
// import './favorite.dart';
// import './memory.dart';
import './vendapp.dart';


class MainVend extends StatefulWidget {
  final String pageTitle;

  MainVend({Key key, this.pageTitle}) : super(key: key);

  @override
  _MainVendState createState() =>_MainVendState();
}

class _MainVendState extends State<MainVend> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      Vendapp(),
      Orders()
    ];
    
    return Scaffold(
        
        body: _tabs[_selectedIndex],
        //bottom tabs
        bottomNavigationBar: new Theme(data: Theme.of(context).copyWith(
          canvasColor:Color.fromRGBO(220, 220, 220, 100),
        ), child: BottomNavigationBar(
          
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.store),
                title: Text(
                  'المتجر',
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_numbered_rtl),
                title: Text(
                  'قائمة الطلبات', 
                )
                ),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor:  Colors.white,
          selectedItemColor:  Colors.blueGrey,
          onTap: _onItemTapped,
         
        ))
        
        
        );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}