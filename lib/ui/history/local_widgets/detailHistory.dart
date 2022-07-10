import 'package:flutter/material.dart';
import 'package:ldp_gateway/model/Transaction.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';

String getDateTime(String time){
  DateTime dateTime = DateTime.parse(time);
  String datetime = '';
  if(dateTime.day < 10) datetime += '0';
  datetime += dateTime.day.toString();
  datetime += '/';
  if(dateTime.month < 3) datetime += '0';
  datetime += dateTime.month.toString();
  datetime += ' ';
  if(dateTime.hour < 10) datetime += '0';
  datetime += dateTime.hour.toString();
  datetime += ':';
  if(dateTime.minute < 10) datetime += '0';
  datetime += dateTime.minute.toString();
  return datetime;
}

Card detailHistory(aTransaction transaction){
  return Card(
    elevation: 0,
    child: InkWell(
      onTap: (){},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            padding: EdgeInsets.all(5),
            child: CircleAvatar(foregroundImage: AssetImage(transaction.coin_icon)),
          ),
          SizedBox(width: 10),
          Expanded(child:
          Container(
              height: 100,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.inputBorder, width: 1))
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 90,
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transaction.type, textAlign: TextAlign.left, overflow: TextOverflow.clip, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.orange),),
                              Text(transaction.pool, textAlign: TextAlign.left, overflow: TextOverflow.clip, maxLines: 1, style: TextStyle(fontSize: 16),),
                              Text(getDateTime(transaction.time), textAlign: TextAlign.left, overflow: TextOverflow.clip, maxLines: 1, style: TextStyle(fontSize: 16, color: AppColors.checkboxBorder),),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(transaction.amount.toString(), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.red),),
                                Text(transaction.coin_code, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 14),),
                                Text('Fee: ' + transaction.fee.toString(), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
              )
            )
          )
        ],
      ),
    ),
  );
}