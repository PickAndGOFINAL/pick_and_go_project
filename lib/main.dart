import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pick_and_go_project/Admin/Add_Items.dart';
import 'package:pick_and_go_project/Admin/Admin.dart';
import 'package:pick_and_go_project/Admin/Edit_Items.dart';
import 'package:pick_and_go_project/Admin/Manage_Items.dart';
import 'package:pick_and_go_project/Cart/Cart.dart';
import 'package:pick_and_go_project/Cart/Cart_Screen.dart';
import 'package:pick_and_go_project/Project_Provider/AdminState.dart';
import 'package:pick_and_go_project/Project_Provider/Progress_hud.dart';
import 'package:pick_and_go_project/Project_Screens/Items_Additions.dart';
import 'package:pick_and_go_project/Project_Screens/Kiosk_Screen.dart';
import 'package:pick_and_go_project/Project_Screens/Maps.dart';
import 'package:pick_and_go_project/Project_Screens/Menu_Screen.dart';
import 'package:pick_and_go_project/Project_Screens/User_Profile.dart';
import 'package:pick_and_go_project/Project_Screens/login_screen.dart';
import 'package:pick_and_go_project/Project_Screens/logo_Screen.dart';
import 'package:pick_and_go_project/Project_Screens/signup_screen.dart';
import 'package:provider/provider.dart';

main ()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
    ChangeNotifierProvider<ProgressHud>(
    create: (context)=>ProgressHud(),),


    ChangeNotifierProvider<AdminState>(
    create: (context)=>AdminState(),),

    ChangeNotifierProvider<Cart>(
    create: (context)=>Cart(),),




      ],
      child: MaterialApp(


        initialRoute:   MenuScreen.id,
        routes: {
          LoginScreen.id :(context)=> LoginScreen(),
          SignupScreen.id:(context)=> SignupScreen(),
          Kiosk_Screen.id:(context)=> Kiosk_Screen(),
          Admin.id : (context)=> Admin(),
          AddItems.id:(context)=>AddItems(),
          ManageItems.id:(context)=>ManageItems(),
          EditItems.id:(context)=>EditItems(),
          MenuScreen.id:(context)=>MenuScreen(),
          ItemsAdditions.id:(context)=>ItemsAdditions(),
          CartScreen.id:(context)=>CartScreen(),
          MapsScreen.id:(context)=>MapsScreen(),
          UserProfile.id:(context)=>UserProfile(),



        },

      ),
    );

  }
}

