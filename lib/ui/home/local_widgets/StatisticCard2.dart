import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';


Card statisticCard(String title, double? number, final void Function() func){
  return Card(
      elevation: 1,
      color: AppColors.gray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // <-- Radius
      ),
      borderOnForeground: true,
      child: InkWell(
          onTap: func,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(title, textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        overflow: TextOverflow.ellipsis, maxLines: 2,),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: number != null ? Text("\$" + number.toString(), textAlign: TextAlign.center,
                          style: TextStyle(fontSize: (number > 9999) ? 18 : 20, color: AppColors.red, fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis))
                          : const SpinKitCircle(
                        color: AppColors.main_red,
                        size: 24,
                      ),
                    ),
                  ]
              ),
            ],
          )
      )
  );
}
