import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class data{

  final String uid;

data ({this.uid});


  final userRef= Firestore.instance.collection('users');

  Future updateinfo (String name , String carplate) async{

    return await userRef.document(uid).setData({
      'UserName':name,
       'UserCarPlate':carplate,

    });

  }

  Stream<QuerySnapshot> get users{
    return userRef.snapshots();
}

Future getCurrentuserdata () async {
   try{

     DocumentSnapshot doc = await userRef.document(uid).get();
     String username =  doc.data['UserName'];
     String usercarplate =  doc.data['UserCarPlate'];
     return [username,usercarplate];

   } catch(e){
     print(e.toString());
     return null;
   }


}



}
