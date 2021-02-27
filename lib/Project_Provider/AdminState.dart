import 'package:flutter/cupertino.dart';

class AdminState extends ChangeNotifier{

  bool Admin = false;

  ChangeAdmin (bool value){

    Admin = value;
    notifyListeners();
  }

}