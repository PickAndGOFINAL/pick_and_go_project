

import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Screens/Items_Additions.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';
import 'package:pick_and_go_project/Project_Services/Storing.dart';
import 'package:pick_and_go_project/Project_Services/Test.dart';
import 'package:provider/provider.dart';
import 'package:pick_and_go_project/Project_Services/Test2.dart';

import 'Cart.dart';


class CartScreen extends StatefulWidget {
  static String id='CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  DateTime _data = new DateTime.now();

  String s1 ='';

  String selcetedtime = "Tap on the icon to select a time";



Future <void> opentimePicker(BuildContext context) async{

  final TimeOfDay t = await showTimePicker(
      context:  context,
      initialTime: TimeOfDay.now());

  if(t!=null){

    setState(() {
      super.setState(() {
        selcetedtime = t.format(context);
        print(selcetedtime);

      });

    });
  }


}

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
    selctedbranch _selctedbranch = selctedbranch(uid: uid);
    dynamic branch = await _selctedbranch.getCurrentuserdata();
    if(branch!=null){
      setState(() {
        s1  = branch[0];
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    print(username);
    print(usercarplate);
    print(s1);
    print(formatDate(_data, [dd, '-' , mm , '-', yyyy]));
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
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,


          ),
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

                          height: screenhighet * .20,
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
                                      SizedBox(height: 10,),
                                      Text('${items[index].Isugar} ',
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

          Builder(
            builder :(context)=> ButtonTheme(
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
 AlertDialog alertDialog = AlertDialog (
   actions: [
     MaterialButton(
       child: Text('Confirm'),
       color: Colors.green,
       onPressed: ()
       {
         try {
           Storing storing = Storing();
           storing.StoreOrder({
             ktotalprice: price,
             karrivaltime: selcetedtime,
             kusername : username,
             kusercarplate : usercarplate,
             kbranch : s1,
             ktodaydate : formatDate(_data, [dd, '-' , mm , '-', yyyy]),

           }, items);
           Scaffold.of(context).showSnackBar(SnackBar(content: Text('Orderd Successfully')));
            Navigator.pop(context);
         }catch(ex){
           print(ex);
         }
       },
     )
   ],
   title: Text('Order Details',style: TextStyle(fontSize: 14,color: Colors.brown),),
   content:   SingleChildScrollView(
     child: Column(
       children: <Widget>[
         Text('Total price of the order: ${price}'),
         SizedBox(height: 20,),
          Row(children: <Widget>[
            Text(('select The arrival time ')),
            SizedBox(width: 10,),
            GestureDetector(

                onTap: (){
                  opentimePicker(context);
                } ,


                child: Icon(Icons.access_time)),
          ],),





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

