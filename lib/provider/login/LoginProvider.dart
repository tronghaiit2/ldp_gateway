import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  bool visible = true;
  String token = "";

  void setVisible(){
    if(visible) visible = false;
    else visible = true;
    notifyListeners();
  }
}

