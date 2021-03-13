import 'package:flutter/material.dart';

const kmaincolor=Color(0xcea762);
const kTextFiled=Color(0xfaf6ef);
const ktapbar = Color(0xFFC1BDB8);


const kItemsCollections ='Items';

const kbarnorders ='barnorders';
const korderdetails = 'orderdetails';
const ktotalprice = 'totalprice';
const karrivaltime = 'arrivaltime';




const kItemName='itemName';
const kItemPrice='itemPrice';
const kItemCategory ='itemCategory';
const kItemImage='itemImage';
const kItemquantity = 'itemquantity';
const kItemSugar = 'itemsugar';

const khotdrinks = 'hot drinks';
const kcolddrinks = 'cold drinks';
const kpastries = 'pastries';






const kSendButtonTextStyle = TextStyle(
  color: Colors.brown,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.brown, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.brown, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.brown, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class MyTextFiled extends StatelessWidget {


  final String Myhint;
  final IconData Myicon;
  final Function Click;
  String Myerrormessage (String error){
    switch(Myhint){

      case  'Please Enter Your Email' : return 'Email is Empty';
      case  'Please Enter Your Password' : return 'Password is Empty';
      case  'Please Enter Your Name' : return 'Name is Empty';
      case  'Please Enter Your CarPlate' : return 'CarPlate is Empty';

  }

  }
  MyTextFiled({@required this.Click,@required this.Myicon , @required this.Myhint });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: TextFormField(
       validator: (value){
         if(value.isEmpty){
           return Myerrormessage(Myhint);

         }

       },
        onSaved: Click,
       cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        obscureText: Myhint =='Please Enter Your Password'? true:false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText:  Myhint,
          prefixIcon: Icon(Myicon,color: Colors.white),
          fillColor: Colors.brown,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(

                color: Colors.black,

              )


          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(

                color: Colors.black,

              )


          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(

                color: Colors.black,

              )


          ),




        ),


      ),
    );
  }
}
