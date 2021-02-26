import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';


class LoginScreen extends StatelessWidget {
  static String id='LoginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

     body: ListView(
     children: <Widget>[
       Padding(
         padding:  EdgeInsets.only(top: 40),
         child: Container(
           height: MediaQuery.of(context).size.height*.2,
           child: Stack(
             alignment: Alignment.center,
             children: <Widget>[
               Image(

                 image: AssetImage('images/logo.png'),
               ),

               Positioned(
                 bottom: 0,
                 child: Text('Pick & GO',
                 style:TextStyle(
                   fontSize: 30,

                 ),
                 ),
               ),








             ],












           ),
         ),
       ),
       SizedBox(height: 30,),
       MyTextFiled(Myhint: 'Please Enter Your Email', Myicon: Icons.email,),
       SizedBox(height: 30,),
       MyTextFiled(Myhint: 'Please Enter Your Password', Myicon: Icons.lock,),
       SizedBox(height: 30,),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 140),
         child: FlatButton(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20),

           ),
      color: Colors.brown,
             onPressed: (){},

             child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.white),)
         ),
       ),
       SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text('Dont have an account?',style: TextStyle(fontSize: 20,color: Colors.brown),),
            SizedBox(width: 10,),
            Text('Sign in',style: TextStyle(fontSize: 20,color: Colors.brown),),




          ],
        )
     ],

     ),


    );
  }
}

