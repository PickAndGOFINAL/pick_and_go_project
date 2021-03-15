
import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Project_Screens/Info.dart';
import 'package:pick_and_go_project/Project_Screens/Kiosk_Screen.dart';
import 'package:pick_and_go_project/Project_Screens/User_Profile.dart';

class Navigationbar extends StatefulWidget {
  static String id ='Navigationbar';
  @override
  _NavigationbarState createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  @override

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[

    Kiosk_Screen(),
    UserProfile(),
    Info(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return  Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_cafe,
            ),
            title: Text(
              'Kiosks',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(
              'Profile',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
            ),
            title: Text(
              'Info',
            ),
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
