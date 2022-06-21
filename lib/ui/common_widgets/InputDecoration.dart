import 'package:flutter/material.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';

InputDecoration textFieldInputDecoration(
  String hintText, String labelText, String? errorText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: AppColors.checkboxBorder),
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.black),
    errorText: errorText,
    errorStyle: TextStyle(color: AppColors.main_red),
    focusColor: AppColors.checkboxBorder,
    errorMaxLines: 2,
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.all(Radius.circular(10))),
    //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

InputDecoration textFieldvsIconInputDecoration(
    String hintText, String labelText, String? errorText, bool passwordVisible, void Function() func){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: AppColors.checkboxBorder),
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.black),
    errorText: errorText,
    errorStyle: TextStyle(color: AppColors.main_red),
    focusColor: AppColors.checkboxBorder,
    errorMaxLines: 2,
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.all(Radius.circular(10))),
    //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
    suffixIcon: IconButton(
      icon: Icon(
        passwordVisible
            ? Icons.visibility
            : Icons.visibility_off,
        color: Colors.black,
      ),
      onPressed: func
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

InputDecoration textFieldSearchDecoration(
    String hintText, void Function() func){
  return InputDecoration(
      suffixIcon: IconButton(
        padding: EdgeInsets.only(bottom: 1.0),
        icon: Icon(Icons.close_rounded, color: AppColors.checkboxBorder, size: 30,),
        onPressed: func,
      ),
      //isDense: true,
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.checkboxBorder),
      contentPadding: EdgeInsets.only(
          left: 20,
          top: 15,
          bottom: 15),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none
      )
  );
}