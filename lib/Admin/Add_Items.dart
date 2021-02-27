import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';

class AddItems extends StatelessWidget {
  static String id='AddItems';
  String ItemName,ItemPrice,ItemCatogry,ItemImage;
  final GlobalKey<FormState> Myglobalkey = GlobalKey<FormState>();
  final storing =Storing();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add items',),
      ),
body: Form(
  key:  Myglobalkey,
  child:   Container(
    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[

        MyTextFiled(

          Myhint: 'Item name',

          Click: (value){

            ItemName=value;

          },

        ),

        SizedBox(height: 10,),

        MyTextFiled(

          Myhint: 'Item Price',

          Click: (value){

            ItemPrice=value;

          },

        ),

        SizedBox(height: 10,),

        MyTextFiled(

          Myhint: 'Item Category',

          Click: (value){

            ItemCatogry=value;

          },

        ),

        SizedBox(height: 10,),

        MyTextFiled(

          Myhint: 'Item Image path',

          Click: (value){

            ItemImage=value;

          },

        ),

        SizedBox(height: 20,),

        RaisedButton(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),

            ),

            onPressed: (){
              if(Myglobalkey.currentState.validate()){
                Myglobalkey.currentState.save();
               storing.addItems(Item(
                   Iname:ItemName,
                   Iprice:ItemPrice,
                   Icatgory:ItemCatogry,
                   Iimage:ItemImage));
              }

            },

            child: Text('Add Item'),

            )



      ],

    ),

  ),
),
    );
  }
}
