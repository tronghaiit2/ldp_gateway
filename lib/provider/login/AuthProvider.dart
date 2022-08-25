import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  String? user;
  String? password;
  String? userError;
  String? passwordError;

  void editUser(String txt){
    if(txt.length <=100){
      user = txt;
      userError = null;
    }
    else {
      user = null;
      userError = "Email đăng nhập dài tối đa 100 ký tự!";
    }
    notifyListeners();
  }
  void editPassword(String txt){
    if(txt.length >=10 && txt.length <=100){
      password = txt;
      passwordError = null;
    }
    else {
      password = null;
      passwordError = "Please fill in private key!";
    }
    notifyListeners();
  }
  bool isValid() {
    if (password != null) return true;
    return false;
  }
}

