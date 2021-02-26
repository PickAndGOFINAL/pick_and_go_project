import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_and_go_project/Project_Provider/Progress_hud.dart';
import 'package:pick_and_go_project/Project_Screens/login_screen.dart';
import 'package:pick_and_go_project/Project_Screens/logo_Screen.dart';
import 'package:pick_and_go_project/Project_Screens/signup_screen.dart';
import 'package:provider/provider.dart';

main ()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProgressHud>(
      create: (context)=>ProgressHud(),

      child: MaterialApp(

        initialRoute: LoginScreen.id  ,

        routes: {
          LoginScreen.id :(context)=> LoginScreen(),
          SignupScreen.id:(context)=> SignupScreen(),






        },

      ),
    );

  }
}
