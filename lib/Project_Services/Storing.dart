import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pick_and_go_project/Items/item.dart';
import 'package:pick_and_go_project/Project_Screens/constants.dart';


class Storing  {


 final Firestore _firestore = Firestore.instance;

 addItems(Item item){

_firestore.collection(kItemsCollections).add(
    {

 kItemName: item.Iname,
 kItemPrice: item.Iprice,
 kItemCategory:item.Icatgory,
 kItemImage:item.Iimage,


}
);



 }
 Stream<QuerySnapshot> loadItems() {


 return _firestore.collection(kItemsCollections).snapshots();

 }


}


/*
 for (var document in DataSnpanshot.documents)

 {
  var docData  = document.data;

  items.add(Item(
   Iname: docData[kItemName],
   Iprice: docData[kItemPrice],
   Icatgory: docData[kItemCategory],
   Iimage: docData[kItemImage],

  ));

 }
 */