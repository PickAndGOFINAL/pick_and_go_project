

import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Screens/Items_Additions.dart';
import 'package:provider/provider.dart';

import 'Cart.dart';


class CartScreen extends StatefulWidget {
  static String id='CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  TimeOfDay time ;


  TimeOfDay picked;

  void initState(){
    super.initState();
    time = TimeOfDay.now();
  }
  Future<Null> selectTime (BuildContext context) async{

picked = await showTimePicker(
    context: context,
    initialTime: time);

  setState(() {
    time = picked;
  });


  }


  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<Cart>(context).items;
    final double screenhighet = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    final double appbarhigeht = AppBar().preferredSize.height;
    final double stautsbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('My cart',
            style: TextStyle(color: Colors.black)
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,


        ),


      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          LayoutBuilder(
              builder: (context, constrains) {
                if (items.isNotEmpty) {
                  return Container(
                    height: screenhighet - stautsbarHeight - appbarhigeht -
                        (screenhighet * .08),
                    child: ListView.builder(itemBuilder:
                        (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(

                          height: screenhighet * .15,
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: screenhighet * .15 / 2,
                                backgroundImage: AssetImage(
                                    items[index].Iimage),

                              ),
                              SizedBox(width: 14,),
                              Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      Text(items[index].Iname,
                                        style: TextStyle(fontSize: 20,
                                            fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10,),
                                      Text('\$ ${items[index].Iprice}', style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10,),
                                      Text('Quantity:${items[index].Iquantity} ',
                                        style: TextStyle(fontSize: 20,
                                            fontWeight: FontWeight.bold),),

                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  GestureDetector(

                                      onTap: () {
                                       deleteitem(context, items[index]);
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
                                        edititem(context, items[index]);
                                      },
                                      child:
                                      Icon(Icons.edit_outlined,
                                        size: 30,
                                        color: Colors.green,
                                      )

                                  ),

                                ],


                              )


                            ],
                          ),

                        ),
                      );
                    },
                      itemCount: items.length,
                    ),
                  );
                } else {
                  return Container(

                    height: screenhighet - (screenhighet * .08) - appbarhigeht -
                        stautsbarHeight,

                    child: Center(
                      child: Text("Cart is Empty"),
                    ),
                  );
                }
              }

          ),

          ButtonTheme(
            minWidth: screenwidth,
            height: screenhighet * .08,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20), topLeft: Radius.circular(20))
            ),
            child: RaisedButton(

              onPressed: () {
               Checkout(items,context);
              },
              child: Text('Checkout'),
              color: Colors.brown.shade400,

            ),
          )
        ],
      ),


    );
  }

  void deleteitem(context, item) {
    Provider.of<Cart>(context, listen: false).deleteItemfromCart(item);
  }

  void edititem (context, item){
    Navigator.pop(context);
    Provider.of<Cart>(context, listen: false).deleteItemfromCart(item);
    Navigator.pushNamed(context, ItemsAdditions.id,arguments: item);
  }

  void Checkout(List<Item> items,context) async{

 var price = totalprice(items);
 AlertDialog alertDialog = AlertDialog(
   title: Text('Order Details',style: TextStyle(fontSize: 14,color: Colors.brown),),
   content: SingleChildScrollView(
     child: ListBody(
       children: <Widget>[
         Text('Total price of the order: '+price.toString()),
          SizedBox(height: 10,),
         GestureDetector(
           onTap: (){
             selectTime(context);
             print(time);
           } ,
             child: Icon(Icons.access_time)),
         SizedBox(height: 10,),
         Text('Time Selected: ${time.hour} : ${time.minute}'),


       ],
     ),
   ),


 );
 await showDialog(context: context,builder: (context){
   return alertDialog;


 });
  }

  totalprice(List<Item> items) {
    var price = 0;
    for (var item in items){
      price += item.Iquantity*int.parse(item.Iprice);
    }
    return price;
  }




}

