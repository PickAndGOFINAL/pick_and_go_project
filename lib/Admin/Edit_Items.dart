import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
class EditItems extends StatefulWidget {
  static String id='EditItems';

  @override
  _EditItemsState createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  final storing =Storing();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
 
      body: StreamBuilder<QuerySnapshot>(
        stream: storing.loadItems() ,
        builder:(context,snapshot)
          {
            if(snapshot.hasData) {
              List <Item> items = [];
              for (var document in snapshot.data.documents)

              {
                var docData  = document.data;

                items.add(Item(
                  Iname: docData[kItemName],
                  Iprice: docData[kItemPrice],
                  Icatgory: docData[kItemCategory],
                  Iimage: docData[kItemImage],

                ));

              }
              return ListView.builder(itemBuilder:
                  (context, index) => Text(items[index].Iname),
                itemCount: items.length,
              );
            }else{
              return Text(('Data is Loading...'));
            }
          },
      ),
      );

   
  }
 
}
