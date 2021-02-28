import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';

class EditItems extends StatelessWidget {
   static String id ='EditItems';
   String ItemName,ItemPrice,ItemCatogry,ItemImage;
   final GlobalKey<FormState> Myglobalkey = GlobalKey<FormState>();
   final storing =Storing();
  @override
  Widget build(BuildContext context) {
      Item items = ModalRoute.of(context).settings.arguments;
    return Scaffold(

      appBar: AppBar(
        title: Text('Edit items',),
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

                  storing.editItems(({
                    kItemName : ItemName,
                    kItemPrice: ItemPrice,
                    kItemCategory: ItemCatogry,
                    kItemImage : ItemImage



                  }), items.Iid);

                  }

                },

                child: Text('Edit Item'),

              )



            ],

          ),

        ),
      ),
    );

  }
}
