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
    if(txt.length >=8 && txt.length <=100){
      password = txt;
      passwordError = null;
    }
    else {
      password = null;
      passwordError = "Mật khẩu dài từ 8 đến 100 ký tự!";
    }
    notifyListeners();
  }
  bool isValid() {
    if (user != null && password != null) return true;
    return false;
  }
}

