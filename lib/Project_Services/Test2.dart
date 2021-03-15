import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class selctedbranch{

  final String uid;

  selctedbranch({this.uid});


  final userRef= Firestore.instance.collection('Selectedbranch');

  /*
  Future updateinfo (String name , String carplate) async{

    return await userRef.document(uid).setData({
      'UserName':name,
       'UserCarPlate':carplate,

    });

  }


   */
  Stream<QuerySnapshot> get users{
    return userRef.snapshots();
  }

  Future getCurrentuserdata () async {
    try{

      DocumentSnapshot doc = await userRef.document(uid).get();
      String branchname =  doc.data['branchname'];

      return [branchname];

    } catch(e){
      print(e.toString());
      return null;
    }

  }

}
