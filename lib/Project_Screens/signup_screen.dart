import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pick_and_go_project/Project_Provider/Progress_hud.dart';
import 'package:pick_and_go_project/Project_Screens/User_Profile.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'package:pick_and_go_project/Project_Screens/login_screen.dart';
import 'package:pick_and_go_project/Project_Services/Auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class SignupScreen extends StatelessWidget {
  static String id='SignupScreen';
  final GlobalKey<FormState> Myglobalkey =GlobalKey<FormState>();
  String UserEmail;
  String UserPassword;
  String UserName;
  String UserCarPlate;
  final _auth = Auth();

  final Firestore _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ProgressHud>(context).loading,
          child: Form(
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
                MyTextFiled(

                  Click:(value){
                   UserEmail=value;

                },

                  Myhint: 'Please Enter Your Email', Myicon: Icons.email,),
                SizedBox(height: 10,),
                MyTextFiled(

                  Click:(value){
                    UserPassword=value;

                  },

                  Myhint: 'Please Enter Your Password', Myicon: Icons.lock,),
                SizedBox(height: 10,),
                MyTextFiled(

                  Click: (value){

                    UserName = value;
                  },

                  Myhint: 'Please Enter Your Name', Myicon: Icons.person,),
                SizedBox(height: 10,),
                MyTextFiled(

                  Click: (value){

                    UserCarPlate = value;
                  },


                  Myhint: 'Please Enter Your CarPlate', Myicon:Icons.directions_car_rounded,),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 140),
                  child: Builder(
                    builder:(context)=> FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),

                        ),
                        color: Colors.brown,
                        onPressed: () async{
                          final progresshud = Provider.of<ProgressHud>(context,listen: false);
                          progresshud.changeLoading(true);
                          try{
                            if(Myglobalkey.currentState.validate()) {
                              Myglobalkey.currentState.save();
                              final authResult= await _auth.SignUp(UserEmail.trim(), UserPassword.trim());
                              _firestore.collection('users').document(authResult.user.uid).setData({
                               'UserName': UserName,
                               'UserCarPlate':UserCarPlate,
                              });
                              Navigator.pushNamed(context, UserProfile.id);
                              progresshud.changeLoading(false);
                        
                            }
                          } on PlatformException catch(e){

                            progresshud.changeLoading(false);
                           Scaffold.of(context).showSnackBar(SnackBar(
                               content:Text(e.message) ));
                          }
                          progresshud.changeLoading(false);
                        },

                        child: Text("Sign in",style: TextStyle(fontSize: 20,color: Colors.white),)
                    ),
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
        ),


      );

  }
}
