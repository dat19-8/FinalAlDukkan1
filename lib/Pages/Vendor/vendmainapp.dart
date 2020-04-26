
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
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.store),
                title: Text(
                  'دكّاني',
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_numbered_rtl),
                title: Text(
                  'بطاقتي',
                )
                ),
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