import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:pick_and_go_project/Project_Screens/login_screen.dart';

class SignupScreen extends StatelessWidget {
  static String id='SignupScreen';
  final GlobalKey<FormState> Myglobalkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Form(
        key: Myglobalkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.only(top: 30),
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
            SizedBox(height: 10,),
            MyTextFiled(Myhint: 'Please Enter Your Email', Myicon: Icons.email,),
            SizedBox(height: 10,),
            MyTextFiled(Myhint: 'Please Enter Your Password', Myicon: Icons.lock,),
            SizedBox(height: 10,),
            MyTextFiled(Myhint: 'Please Enter Your Name', Myicon: Icons.person,),
            SizedBox(height: 10,),
            MyTextFiled(Myhint: 'Please Enter Your CarPlate', Myicon:Icons.directions_car_rounded,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 140),
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  color: Colors.brown,
                  onPressed: (){

                  if(Myglobalkey.currentState.validate()) {

                  }

                  },

                  child: Text("Sign in",style: TextStyle(fontSize: 20,color: Colors.white),)
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text('Do you have an account?',style: TextStyle(fontSize: 20,color: Colors.brown),),
                SizedBox(width: 10,),
                GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, LoginScreen.id );
                    },
                    child: Text(
                      'Log in',
                      style:
                      TextStyle(fontSize: 20,color: Colors.brown),)),




              ],
            )
          ],

        ),
      ),


    );
  }
}
