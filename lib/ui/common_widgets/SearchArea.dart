import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:ldp_gateway/ui/common_widgets/ResponsiveLayout.dart';
import 'package:ldp_gateway/ui/common_widgets/InputDecoration.dart';

import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:ldp_gateway/utils/constant/TextConstant.dart';

Container SearchArea(){
  return Container(
    decoration: BoxDecoration(
      color: AppColors.gray,
      borderRadius: BorderRadius.all(Radius.circular(30))
    ),
    alignment: Alignment.center,
    margin: EdgeInsets.all(20),
    child: TextField(
    style: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    controller: null,
    cursorColor: AppColors.checkboxBorder,
    decoration: textFieldSearchDecoration("Tìm kiếm", (){}),
    onChanged: (value){},
  ));
}