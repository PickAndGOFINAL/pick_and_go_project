import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
 int _selectedSize = 0;
 int _selectedSize1 = 0;
 String sugar = 'Little Sugar';
 int sizecost =0;


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
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                         SizedBox(height: 20,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             selectCupSize(),
                             SizedBox(width: 20,),
                             selectSugar(),


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
 Widget selectCupSize() {
   return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[
       InkWell(
         onTap: () {
           setState(() {
             _selectedSize = 0;
             sizecost =0;
             print(sizecost);
           });
         },
         child: Container(
           height: 35,
           width: 35,
           decoration: BoxDecoration(
               border: Border(
                   bottom: BorderSide(
                       color: _selectedSize == 0
                           ? Colors.brown
                           : Colors.transparent,
                       width: 4))),
           child: SvgPicture.asset("images/icons/coffee.svg",width: 10,height: 10,),
         ),
       ),
       SizedBox(
         width: 10,
       ),
       InkWell(
         onTap: () {
           setState(() {
             _selectedSize = 1;
             sizecost =2;
             print(sizecost);
           });
         },
         child: Container(
           height: 45,
           width: 45,
           decoration: BoxDecoration(
               border: Border(
                   bottom: BorderSide(
                       color: _selectedSize == 1
                           ? Colors.brown
                           : Colors.transparent,
                       width: 4))),
           child: SvgPicture.asset("images/icons/coffee.svg",width: 20,height: 20,),
         ),
       ),
       SizedBox(
         width: 10,
       ),
       InkWell(
         onTap: () {
           setState(() {
             _selectedSize = 2;
             sizecost =3;
             print(sizecost);
           });
         },
         child: Container(
           height: 65,
           width: 65,
           decoration: BoxDecoration(
               border: Border(
                   bottom: BorderSide(
                       color: _selectedSize == 2
                           ? Colors.brown
                           : Colors.transparent,
                       width: 4))),
           child: SvgPicture.asset("images/icons/coffee.svg",width: 22,height: 20,),
         ),
       ),
     ],
   );
 }







 Widget selectSugar() {
   return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[
       InkWell(
         onTap: () {
           setState(() {
             _selectedSize1 = 0;
             sugar ="Little Sugar";
             print(sugar);
           });
         },
         child: Container(
           height: 35,
           width: 35,
           decoration: BoxDecoration(
               border: Border(
                   bottom: BorderSide(
                       color: _selectedSize1 == 0
                           ? Colors.brown
                           : Colors.transparent,
                       width: 4))),
           child: SvgPicture.asset("images/icons/sugar.svg",width: 10,height: 10,),
         ),
       ),
       SizedBox(
         width: 10,
       ),
       InkWell(
         onTap: () {
           setState(() {
             _selectedSize1 = 1;
             sugar ="Medium Sugar";
             print(sugar);
           });
         },
         child: Container(
           height: 45,
           width: 45,
           decoration: BoxDecoration(
               border: Border(
                   bottom: BorderSide(
                       color: _selectedSize1 == 1
                           ? Colors.brown
                           : Colors.transparent,
                       width: 4))),
           child: SvgPicture.asset("images/icons/sugar.svg",width: 20,height: 20,),
         ),
       ),
       SizedBox(
         width: 10,
       ),
       InkWell(
         onTap: () {
           setState(() {
             _selectedSize1 = 2;
             sugar ="Extra Sugar";
             print(sugar);
           });
         },
         child: Container(
           height: 65,
           width: 65,
           decoration: BoxDecoration(
               border: Border(
                   bottom: BorderSide(
                       color: _selectedSize1 == 2
                           ? Colors.brown
                           : Colors.transparent,
                       width: 4))),
           child: SvgPicture.asset("images/icons/sugar.svg",width: 23,height: 23,),
         ),
       ),
     ],
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
    item.Isugar = sugar;
    var one = int.parse(item.Iprice);
    one = one+ sizecost;
    item.Iprice = one.toString();

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

