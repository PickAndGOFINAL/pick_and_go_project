import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Storing storing = Storing();

  @override
  Widget build(BuildContext context) {
    String DocId = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details',),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: storing.loadOrdersDetails(DocId),
          builder: (context, snapshot) {
            if(snapshot.hasData){

             List<Item> items = [];
             for(var doc in snapshot.data.documents)
             {
             
               items.add(Item(
               Iname: doc.data[kItemName],
               Iprice: doc.data[kItemPrice],
               Iquantity: doc.data[kItemquantity],
               Isugar: doc.data[kItemSugar],


               ));

             } return ListView.builder(

               itemBuilder: (context,index)=> Padding(
                 padding: const EdgeInsets.all(20),
                 child: Container(
                   height: MediaQuery.of(context).size.height*.2,
                   color: Colors.white,


                   child: Padding(
                     padding: const EdgeInsets.all(10),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
                         Text('Item Name : ${items[index].Iname}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                         SizedBox(height: 5,),
                         Text('Item Price : ${items[index].Iprice}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                         SizedBox(height: 5,),
                         Text('Item Quantity : ${items[index].Iquantity}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                         SizedBox(height: 5,),
                         Text('Sugar level : ${items[index].Isugar}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),



                       ],
                     ),
                   ),

                 ),
               ),
               itemCount: items.length,
             );

            }else{
              return Center(child: Text('Loading Orders...'),);
            }

          }
      ),
    );
  }
}
