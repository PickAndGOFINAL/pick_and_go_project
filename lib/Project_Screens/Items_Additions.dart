import 'package:flutter/material.dart';
import 'package:pick_and_go_project/Cart/Cart.dart';
import 'package:pick_and_go_project/Cart/Cart_Screen.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:provider/provider.dart';

class ItemsAdditions extends StatefulWidget {

  static String id ='ItemsAdditions';

  @override
  _ItemsAdditionsState createState() => _ItemsAdditionsState();
}

class _ItemsAdditionsState extends State<ItemsAdditions> {
 int Itemquantity = 1;
  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(item.Iimage)),

          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height*.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   GestureDetector
                     (
                       onTap: (){
                         Navigator.pop(context);
                       },
                       child: Icon(Icons.arrow_back)),

                   GestureDetector
                     (
                     onTap: (){
                       Navigator.pushNamed(context, CartScreen.id);
                     },
                       child: Icon(Icons.shopping_cart)),

                 ],


            ),
          ),
    ),
          Positioned(
            bottom: 0,
            child: Column(

              children: [
                Opacity(

                  child: Container(
                    color:Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*.3,
                    child: Column(
                      children: <Widget>[
                        Text('order Name: ${item.Iname}' ,
                          style: TextStyle(fontSize: 20,fontWeight :FontWeight.bold,color: Colors.black),

                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('order Price: ${item.Iprice} Riyals',
                          style: TextStyle(fontSize: 20,fontWeight :FontWeight.bold,color: Colors.black),

                        ),
                        Row(
                          children: <Widget>[
                            ClipOval(

                              child: Material(
                                color: Colors.yellow,
                                child: GestureDetector(
                                  onTap: (){
                                   addQuantity();
                                  },
                                  child: SizedBox(
                                    child: Icon(Icons.add),
                                    height: 28,
                                    width: 28,

                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(Itemquantity.toString()),
                            SizedBox(width: 10,),
                            ClipOval(

                              child: Material(
                                color: Colors.yellow,
                                child: GestureDetector(
                                  onTap: (){
                                   subQuantity();
                                  },
                                  child: SizedBox(
                                    child: Icon(Icons.remove),
                                    height: 28,
                                    width: 28,

                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  opacity: .5,

                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*.08,
                  child: Builder(
                    builder:(context)=> RaisedButton(
                      color: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                      ),
                      child : Text('Add to cart'),
                      onPressed: (){
                       additemtocart(context,item);
                      },
                    ),
                  ),
                ),
              ],
            ),

          )
        ],

      ),


    );
  }
 void addQuantity(){
   setState(() {
     Itemquantity++;
   });

 }
 void subQuantity(){
   if(Itemquantity>1){
     setState(() {
       Itemquantity--;
     });

   }
 }

  void additemtocart(context,item) {
    Cart cart=  Provider.of<Cart>(context,listen: false);
    item.Iquantity = Itemquantity;
    bool exist = false;
    var itemsincart = cart.items;
    if(itemsincart.length<5){
      for (var productExistInCart in itemsincart){
        if(productExistInCart==item){
          exist = true;
        }
      }


      if(exist)
      {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('you have already added this item')));

      } else{
        cart.addItem(item);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Added to cart')));
      }

    } else {

      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('You can not add more items')));
    }


  }
  }

