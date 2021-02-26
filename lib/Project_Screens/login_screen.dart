import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
import 'package:pick_and_go_project/Project_Screens/signup_screen.dart';
import 'package:pick_and_go_project/Project_Services/Auth.dart';

class LoginScreen extends StatelessWidget {
  static String id='LoginScreen';
  final GlobalKey<FormState> Myglobalkey =GlobalKey<FormState>();
  String UserEmail;
  String UserPassword;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

     body: Form(
       key: Myglobalkey,
       child: ListView(
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
         MyTextFiled(
           Click:(value){

             UserEmail = value;


           },Myhint: 'Please Enter Your Email', Myicon: Icons.email,),
         SizedBox(height: 30,),
         MyTextFiled(
           Click: (value){
               UserPassword=value;
             },Myhint: 'Please Enter Your Password', Myicon: Icons.lock,),
         SizedBox(height: 30,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 140),
           child: FlatButton(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20),

             ),
        color: Colors.brown,
               onPressed: ()async{
                 if(Myglobalkey.currentState.validate()) {
                   Myglobalkey.currentState.save();
                   final result = await _auth.SignIn(UserEmail, UserPassword);
                   print(result.user.uid);
                 }
               },

               child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.white),)
           ),
         ),
         SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text('Dont have an account?',style: TextStyle(fontSize: 20,color: Colors.brown),),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context,  SignupScreen.id );
                },
                  child: Text(
                    'Sign in',
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

