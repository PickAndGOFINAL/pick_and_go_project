

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Project_Screens/signup_screen.dart';
import 'package:pick_and_go_project/Project_Services/Test.dart';
//DocumentSnapshot doc;
final userRef= Firestore.instance.collection('users');

class UserProfile extends StatefulWidget {
  static String id='User_Profile';


  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

String uid='';
String username ='';
String usercarplate = '';


  @override
  void initState(){
    super.initState();
    getcurrentuser ();


  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getcurrentuser () async{

    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    data data1 = data(uid: uid);
    dynamic names = await data1.getCurrentuserdata();
    if(names!=null){
      setState(() {
        username = names[0];
        usercarplate = names[1];

      });

    }
  }

  Widget build(BuildContext context)   {



    return Scaffold(
        backgroundColor: Colors.brown,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 50),
          child: Column(

            children: <Widget>[
              /*
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: AssetImage('images/logo.png'),
              ),

               */
              Text(
                "User Profile",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              Text(
                "Pick & GO",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey[200],
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

           Card(
             color: Colors.white,
             margin: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 25.0),
             child: ListTile(
               leading:
               Icon(Icons.person,
               color: Colors.black,),
               title: Text(username ,style: TextStyle(fontSize: 20,color: Colors.brown),),

             ),
            
           ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 25.0),
                child: ListTile(
                  leading:
                  Icon(Icons.directions_car_rounded,
                    color: Colors.black,),
                  title: Text(usercarplate ,style: TextStyle(fontSize: 20,color: Colors.brown),),

                ),

              ),
              SizedBox(height: 30,),
              FlatButton(
                  color: Colors.white,

                  onPressed: ()async{

              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, SignupScreen.id);


              },
                child: Text('Log out'),
              )

            ],
          ),
        ));
  }
}


