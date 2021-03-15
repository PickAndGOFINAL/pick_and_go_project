import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  static String id ='Info';
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 50),
          child: Column(

            children: <Widget>[

              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: AssetImage('images/FCIT.jpg'),
              ),


              Text(
                "Info",
                style: TextStyle(
                  fontSize: 40.0,
                  color:Colors.blueGrey[200],
                  fontWeight: FontWeight.bold,

                ),
              ),

              SizedBox(
                height:20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 25.0),
                child: ListTile(

                  title: Text("The names of the students who worked on this application:",style: TextStyle(fontSize: 20,color: Colors.black),textAlign: TextAlign.center),

                ),

              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 25.0),
                child: ListTile(

                  title: Text("Khalid Alsahli",style: TextStyle(fontSize: 20,color: Colors.black),),

                ),

              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 20.0),
                child: ListTile(

                  title: Text("Saeed Ghassal",style: TextStyle(fontSize: 20,color: Colors.black),),

                ),

              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 20.0),
                child: ListTile(

                  title: Text("Assaf Alharbi",style: TextStyle(fontSize: 20,color: Colors.black),),

                ),

              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 20.0),
                child: ListTile(

                  title: Text("The supervision of Dr. Reda Salameh",style: TextStyle(fontSize: 20,color: Colors.black),),

                ),

              ),





            ],
          ),
        ));
  }
}
