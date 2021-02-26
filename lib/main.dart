import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_and_go_project/Project_Screens/logo_Screen.dart';

main ()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: 'logoScreens',

      routes: {
        'logoScreens':(context)=> logoScreens(),





      },

    );

  }
}
