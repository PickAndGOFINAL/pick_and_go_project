import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Admin/Edit_Items.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
class ManageItems extends StatefulWidget {
  static String id='ManageItems';

  @override
  _ManageItemsState createState() => _ManageItemsState();
}

class _ManageItemsState extends State<ManageItems> {
  final storing =Storing();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
   backgroundColor: Colors.white,
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
                  Iid: document.documentID,
                  Iname: docData[kItemName],
                  Iprice: docData[kItemPrice],
                  Icatgory: docData[kItemCategory],
                  Iimage: docData[kItemImage],

                ));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   // (Hint) Number of Grid in each row
                    crossAxisCount:2 ,
                    childAspectRatio: .7,

                ),
                itemBuilder: (context, index) =>

                    Padding(
                   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  child: GestureDetector(
                    child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(items[index].Iimage),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 90,
                            color: Colors.white,
                           child: Padding(
                             padding: const EdgeInsets.only(left: 40),
                             child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 // (Hint) The Detials of the each Item such as ( price , Name)
                                 Text(items[index].Iname,style: TextStyle(fontSize: 15)),
                                 Padding(
                                   padding: const EdgeInsets.only(left: 40),
                                   child: Text('${items[index].Iprice} \$',style: TextStyle(fontSize: 15)),
                                 ),

                                 Row(children: <Widget> [

                                   GestureDetector(

                                       onTap: () {
                                         storing.deleteItems(items[index].Iid);
                                       },
                                       child:
                                       Icon(Icons.delete_rounded,
                                         size: 30,
                                         color: Colors.red,
                                       )

                                   ),
                                   SizedBox(width: 15,),
                                   GestureDetector(

                                       onTap: () {
                                          Navigator.pushNamed(context, EditItems.id ,arguments: items[index]);
                                       },
                                       child:
                                       Icon(Icons.edit,
                                         size: 30,
                                         color: Colors.green,
                                       )

                                   ),





                                 ],)

                               ],


                             ),
                           ),
                          ),
                        ),
                      ),




                    ],



                    ),
                  ),
                ),
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

