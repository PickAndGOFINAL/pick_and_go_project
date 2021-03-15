import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Admin/Add_Items.dart';
import 'package:pick_and_go_project/Admin/Manage_Items.dart';
import 'package:pick_and_go_project/Admin/View_Orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pick_and_go_project/Project_Screens/logo_Screen.dart';
class Admin extends StatelessWidget {
  static String id='Admin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panal',),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity,),

         RaisedButton(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20),
           ),
           onPressed: ()

         {

           Navigator.pushNamed(context, AddItems.id);

         },

           child: Text('Adding Items to Cafe'),
         ),
          SizedBox(height: 20,),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            onPressed: ()

          {

            Navigator.pushNamed(context, ManageItems.id);
          },

              child: Text('Editing on Items'),
          ),
          SizedBox(height: 20,),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            onPressed: ()
          {
            Navigator.pushNamed(context, ViewOrders.id);
          },

            child: Text('View User orders'),
          ),

          SizedBox(height: 20,),

          FlatButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),),
            onPressed: ()async{

              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, logoScreens.id);


            },
            child: Text('Log out'),
          )


        ],


      ),



    );
  }
}
