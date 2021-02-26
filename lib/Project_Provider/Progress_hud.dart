import 'package:flutter/cupertino.dart';

class  ProgressHud extends ChangeNotifier {
  bool loading =false;

  changeLoading(bool value){

    loading = value;
    notifyListeners();
  }
}