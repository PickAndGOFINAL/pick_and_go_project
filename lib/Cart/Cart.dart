import 'package:flutter/cupertino.dart';
import 'package:pick_and_go_project/Items/item.dart';

class Cart extends ChangeNotifier{

  List <Item> items =[];

 addItem(Item item){
  items.add(item);
 notifyListeners();
 }
 deleteItemfromCart(Item item){
   items.remove(item);
   notifyListeners();
 }
}