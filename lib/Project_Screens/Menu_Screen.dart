 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Admin/Edit_Items.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Services/Auth.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';

import 'constants.dart';

class MenuScreen extends StatefulWidget {
  static String id ='MenuScreen';

   @override
   _MenuScreenState createState() => _MenuScreenState();
 }

 class _MenuScreenState extends State<MenuScreen> {
   final storing = Storing();
   List <Item> _items;
   final auth = Auth();
   FirebaseUser loggeduser;
   int tabbarindex = 0;

   @override
   Widget build(BuildContext context) {
     return Stack(
       children: <Widget>[

         DefaultTabController(
           length: 3,

           child: Scaffold(
             backgroundColor: Colors.white,
             appBar: (AppBar(
               title: Text('Menu'),
               backgroundColor: Colors.brown,
               elevation: 0,


               bottom: TabBar(
                 indicatorColor: Colors.white,
                 onTap: (value) {
                   setState(() {
                     tabbarindex = value;
                   });
                 },
                 tabs: [
                   Text('Hot Drinks', style: TextStyle(
                       color: tabbarindex == 0 ? Colors.black : ktapbar,
                       fontSize: tabbarindex == 0 ? 18 : null),),

                   Text('Cold Drinks', style: TextStyle(
                       color: tabbarindex == 1 ? Colors.black : ktapbar,
                       fontSize: tabbarindex == 1 ? 18 : null),),

                   Text('Pastries', style: TextStyle(
                       color: tabbarindex == 2 ? Colors.black : ktapbar,
                       fontSize: tabbarindex == 2 ? 18 : null),),
                 ],
               ),
             )),
             body: TabBarView(
               children: <Widget>[

                 HotDrinks(),
                 ColdDrinks(),
                  Pastries(),


               ],


             ),

           ),
         ),


       ],

     );
   }

 Widget HotDrinks() {

   return StreamBuilder<QuerySnapshot>(
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
         _items = [...items];
         items.clear();
         items = getItemsCatogry(khotdrinks);
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
   );





 }



 Widget ColdDrinks() {
      List <Item> items ;
      items = getItemsCatogry(kcolddrinks);
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



 }

   List<Item> getItemsCatogry(String khotdrinks) {

     List <Item> items =[];
     try{
       for (var item in _items){
         if (item.Icatgory==khotdrinks){
           items.add(item);
         }
       }
     } on Error catch(e){
       print(e);
     }

     return items;
   }

  Widget Pastries() {

    List <Item> items ;
    items = getItemsCatogry(kpastries);
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



  }

 }





