import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldp_gateway/blockchain/pool_gateway.dart';
import 'package:ldp_gateway/model/Transaction.dart';
import 'package:ldp_gateway/provider/new_transaction/NewTransactionProvider.dart';
import 'package:ldp_gateway/route.dart';
import 'package:ldp_gateway/ui/common_widgets/Buttons.dart';
import 'package:ldp_gateway/ui/common_widgets/InputDecoration.dart';
import 'package:ldp_gateway/ui/common_widgets/NotificationDialog.dart';
import 'package:ldp_gateway/ui/common_widgets/ResponsiveLayout.dart';
import 'package:ldp_gateway/ui/home/local_widgets/CoinsCarousel.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:ldp_gateway/utils/constant/TextConstant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, required this.transaction}) : super(key: key);
  final Transaction transaction;

  static int alertDialogCount = 0;

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  late NewTransactionProvider _newTransactionProvider;
  late Transaction transaction = widget.transaction;

  @override
  Widget build(BuildContext context) {
    _newTransactionProvider = context.watch<NewTransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transaction.type, style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.main_blue)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.main_blue,),
                onPressed: () {
                  Navigator.pop(context);
                }
            );
          },
        ),
        actions:
        <Widget>[
          IconButton(onPressed: (){},
              padding: EdgeInsets.only(right: 20),
              icon: Icon(Icons.menu_rounded, size: 32, color: AppColors.blue,))
        ],
        centerTitle: true,
        backgroundColor: AppColors.white,
        toolbarHeight: 50,
        elevation: 1,
        // give the app bar rounded corners
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            headerInformation(),
            fillAmount(),
            SafeArea(
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
                  child: selectButton("THỰC HIỆN GIAO DỊCH", () async {
                    transaction.amount = _newTransactionProvider.amount;
                    transaction.fee = _newTransactionProvider.fee;

                    switch(widget.transaction.pool) {
                      case "Aave":
                        if(widget.transaction.type == TextConstant.transaction_type[0]){
                          await deposit(widget.transaction.pool, TextConstant.aaveTokenList[widget.transaction.coin_code] ?? "", transaction.amount);
                        }
                        else if (widget.transaction.type == TextConstant.transaction_type[1]){
                          await borrow(widget.transaction.pool, TextConstant.aaveTokenList[widget.transaction.coin_code] ?? "", transaction.amount);
                        }
                        else if (widget.transaction.type == TextConstant.transaction_type[2]){
                          await repay(widget.transaction.pool, TextConstant.aaveTokenList[widget.transaction.coin_code] ?? "", transaction.amount);
                        }
                        else if (widget.transaction.type == TextConstant.transaction_type[3]){
                          await withdraw(widget.transaction.pool, TextConstant.aaveTokenList[widget.transaction.coin_code] ?? "", transaction.amount);
                        }
                        else {
                          if(NewTransaction.alertDialogCount == 0){
                            NewTransaction.alertDialogCount++;
                            showWarningDialog("Lỗi sao dịch, giao dịch lại!", context, (){
                              if(NewTransaction.alertDialogCount > 0) NewTransaction.alertDialogCount = 0;
                            });
                          }
                        }
                        break;

                      // case "Compound":
                      //   if(widget.transaction.type == TextConstant.transaction_type[0]){
                      //     await deposit(widget.transaction.pool, TextConstant.compoundTokenList[widget.transaction.coin_code] ?? "", transaction.amount);
                      //   }
                      //   else if (widget.transaction.type == TextConstant.transaction_type[1]){
                      //     await borrow(widget.transaction.pool, TextConstant.compoundTokenList[widget.transaction.coin_code] ?? "", transaction.amount);
                      //   }
                      //   else if (widget.transaction.type == TextConstant.transaction_type[2]){
                      //     await repay(widget.transaction.pool, TextConstant.compoundTokenList[widget.transaction.coin_code] ?? "", transaction.amount);
                      //   }
                      //   else if (widget.transaction.type == TextConstant.transaction_type[3]){
                      //     await withdraw(widget.transaction.pool, TextConstant.compoundTokenList[widget.transaction.coin_code] ?? "", transaction.amount);
                      //   }
                      //   else {
                      //     if(NewTransaction.alertDialogCount == 0){
                      //       NewTransaction.alertDialogCount++;
                      //       showWarningDialog("Lỗi sao dịch, giao dịch lại!", context, (){
                      //         if(NewTransaction.alertDialogCount > 0) NewTransaction.alertDialogCount = 0;
                      //       });
                      //     }
                      //   }
                      //   break;
                    }

                    if(_newTransactionProvider.isValid()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.home2, (Route<dynamic> route) => false);
                    }
                    else{
                      if(NewTransaction.alertDialogCount == 0){
                        NewTransaction.alertDialogCount++;
                        showWarningDialog("Hãy nhập lượng tiền và \n giao dịch cao hơn tối thiểu!", context, (){
                          if(NewTransaction.alertDialogCount > 0) NewTransaction.alertDialogCount = 0;
                        });
                      }
                    }
                  }),
                )
            ),
          ],
        ),
      ),
    );
  }

  Container headerInformation(){
    return Container(
        height: 150,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.inputBorder,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          color: AppColors.white
        ),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        margin: EdgeInsets.only(bottom: 5),
        child: Row (children: [
          Container(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Pool: ', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20,), overflow: TextOverflow.ellipsis),
                Text('Coin: ', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20,), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: AppColors.checkboxBorder)
                  ),
                  margin: EdgeInsets.only(right: 20),
                  child: Text(widget.transaction.pool, textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: AppColors.checkboxBorder)
                  ),
                  margin: EdgeInsets.only(right: 20),
                  child: Text(widget.transaction.coin_name, textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          )
        ],)
    );
  }

  Container fillAmount(){
    return Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('SỐ LƯỢNG', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.black,),
              overflow: TextOverflow.ellipsis, maxLines: 2,),
                //Text('\$', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.main_blue,),),
            TextField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.main_blue,),
              controller: null,
              cursorColor: AppColors.checkboxBorder,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                //isDense: true,
                  hintText: '---',
                  hintStyle: TextStyle(color: AppColors.checkboxBorder),
                  contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none
                  )
              ),
              onChanged: (value){
                _newTransactionProvider.editAmount(value);
              },
            ),
            // Text((_newTransactionProvider.amount/widget.transaction.coin_rate).toString() + ' ' + widget.transaction.coin_code, textAlign: TextAlign.left,
            //   style: TextStyle(fontSize: 16, color: Colors.black,),
            //   overflow: TextOverflow.ellipsis),
            Text(_newTransactionProvider.amountError ?? '', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.main_red,),
                overflow: TextOverflow.ellipsis),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Phí: ', textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blue,),
                  overflow: TextOverflow.ellipsis),
              Container(
                width: 100,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.main_blue,),
                  controller: null,
                  cursorColor: AppColors.checkboxBorder,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    //isDense: true,
                      hintText: '---',
                      hintStyle: TextStyle(color: AppColors.checkboxBorder),
                      contentPadding: EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none
                      )
                  ),
                  onChanged: (value){
                    _newTransactionProvider.editFee(value, BigInt.from(0));
                  },
                ),
              ),
              // Text('/\$0.50', textAlign: TextAlign.left,
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blue,),
              //     overflow: TextOverflow.ellipsis),
            ],),
            Text(_newTransactionProvider.feeError ?? '', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.main_red,),
                overflow: TextOverflow.ellipsis),
            transactionCard()
          ],
        )
    );
  }

  Container transactionCard(){
    return Container(
      height: 160,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: AppColors.checkboxBorder)
        ),
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Số lượng: ', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
                overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text(_newTransactionProvider.amount.toString(), textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
                overflow: TextOverflow.ellipsis, maxLines: 2,),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phí giao dịch: ', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
                  overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text(_newTransactionProvider.fee.toString(), textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
                  overflow: TextOverflow.ellipsis, maxLines: 2,),
              ],),
            Container(
              height: 2,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: AppColors.checkboxBorder)
              ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng cộng: ', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
                  overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text(_newTransactionProvider.total().toString(), textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
                  overflow: TextOverflow.ellipsis, maxLines: 2,),
              ],),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('', textAlign: TextAlign.center,
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),
            //       overflow: TextOverflow.ellipsis, maxLines: 2,),
            //     Text((_newTransactionProvider.total() / widget.transaction.coin_rate).toString() + ' ' + widget.transaction.coin_code, textAlign: TextAlign.center,
            //       style: TextStyle(fontSize: 16, color: Colors.black,),
            //       overflow: TextOverflow.ellipsis, maxLines: 2,),
            //   ],),
          ],
        )
    );
  }
}

