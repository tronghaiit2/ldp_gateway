import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';


Card statisticCard(String coin, BigInt? number, final void Function() func){
  return Card(
      elevation: 0,
      color: AppColors.gray100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // <-- Radius
      ),
      borderOnForeground: true,
      child: InkWell(
          onTap: func,
          child: Center(
              child: number != null ? Text(number.toString(), textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red,),
                  overflow: TextOverflow.ellipsis)
                  : const SpinKitCircle(
                color: AppColors.main_red,
                size: 24,
              )
          )
      )
  );
}
