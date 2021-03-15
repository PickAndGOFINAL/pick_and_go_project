import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Admin/Order.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';

import 'Order_Details.dart';

class ViewOrders extends StatelessWidget {
  static String id = 'ViewOrders';
  final Storing storing = Storing();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Orders',),
        ),
     body: StreamBuilder<QuerySnapshot> (
      stream: storing.loadOrders() ,
      builder: (context,snapshot)
      {
       if (!snapshot.hasData){
         return Center(
           child: Text('There is no Orders!!'),
         );
       }
       else{
         List<Order> orders =[];
         for(var doc in snapshot.data.documents){
           orders.add(Order(
             DocId: doc.documentID,
             selectedtime: doc.data[karrivaltime],
           totalPrice: doc.data[ktotalprice],
               username:doc.data[kusername],
             usercarplate: doc.data[kusercarplate],
             branch: doc.data[kbranch],
             todaydate: doc.data[ktodaydate],

           ));

         }
         return ListView.builder(itemBuilder:
         (context,index)=>
             Padding(
               padding: const EdgeInsets.all(20),
               child: GestureDetector(
                 onTap: (){
                   Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index].DocId );

                 },
                 child: Container(
                   height: MediaQuery.of(context).size.height*.4,
                   color: Colors.white,
                   child: Padding(
                     padding: const EdgeInsets.all(10),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
                         Text('Total Price = \$${orders[index].totalPrice}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         Text('Arrival Time : ${orders[index].selectedtime}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         Text('Customer name : ${orders[index].username}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         Text('Car Plate : ${orders[index].usercarplate}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         Text('Branch :  ${orders[index].branch}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         Text('Today Date : ${orders[index].todaydate}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),



                       ],


                     ),
                   ),

                 ),
               ),
             ),
             itemCount: orders.length,

         );
       }


      },



     )
    );
  }
}
