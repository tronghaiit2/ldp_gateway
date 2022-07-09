import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:ldp_gateway/model/Coin.dart';
import 'package:ldp_gateway/model/Statistic.dart';
import 'package:ldp_gateway/model/Transaction.dart';
import 'package:ldp_gateway/provider/new_transaction/NewTransactionProvider.dart';
import 'package:ldp_gateway/ui/common_widgets/ResponsiveLayout.dart';
import 'package:ldp_gateway/ui/home/local_widgets/StatisticCard.dart';
import 'package:ldp_gateway/ui/new_transactions/NewTransaction.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:ldp_gateway/utils/constant/TextConstant.dart';
import 'package:provider/provider.dart';

class StatisticsTab extends StatefulWidget {
  const StatisticsTab({Key? key, required this.statistic_type, required this.listStatistic}) : super(key: key);
  final int statistic_type;
  final List<Coin> listStatistic;

  @override
  State<StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> {

  late Map<String, List<String>> aCoinList = {};

  bool isLoading = false;

  Future<void> getData() async {
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    WidgetsFlutterBinding.ensureInitialized();

    return  FutureBuilder(
        builder: (context, storeSnapShot) {
          if (storeSnapShot.connectionState == ConnectionState.none &&
              storeSnapShot.hasData == false ||
              storeSnapShot.data == null) {
            return Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    displacement: 0,
                    color: AppColors.main_red,
                    onRefresh: getData,
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            for(var i = 0; i < widget.listStatistic.length; i++)
                              coinStatistic(i)
                          ],
                        )
                    )
                )
            );
          }
          return  Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  displacement: 0,
                  color: AppColors.main_red,
                  onRefresh: getData,
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                      children: [
                        for(var i = 0; i < widget.listStatistic.length; i++)
                          coinStatistic(i)
                      ],)
                  )
              )
          );
        },
        future: getData(),
    );
  }

  Container coinStatistic(int count){
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.inputBorder,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(0,),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Column(
            children: [
            Container(
              width: 70,
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Text("No. " + (count+1).toString(), textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: AppColors.blue, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis, maxLines: 2,),
            ),
            Container(
              height: 80,
              width: 60,
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.center,
              child: Image.asset(widget.listStatistic[count].icon, height: 50, width: 50, fit: BoxFit.fill),
            ),
          ],),
          Expanded(
            child: Column(
              //crossAxisAlignment:  CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: GridView.count(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      scrollDirection: Axis.vertical,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      shrinkWrap: true,
                      primary: false,
                      childAspectRatio: 3,
                      crossAxisCount: 3,
                      children:
                      [
                        Container(
                          child: Text("Số dư", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.black),),
                        ),
                        Container(
                          child: Text("Đã gửi", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.black),),
                        ),
                        Container(
                          child: Text("Số nợ", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.black),),
                        ),
                      ]
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border(bottom: BorderSide(color: AppColors.gray,  width: 1.0, style : BorderStyle.solid)),
                  ),
                ),
                GridView.count(
                    padding: EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    shrinkWrap: true,
                    primary: false,
                    childAspectRatio: 2,
                    crossAxisCount: 3,
                    children:
                    [
                        statisticCard(widget.listStatistic[count].code, widget.listStatistic[count].balance, () {
                          var transaction = Transaction("Account", widget.listStatistic[count].pool, widget.listStatistic[count].name, widget.listStatistic[count].code,
                              widget.listStatistic[count].rate,widget.listStatistic[count].icon, TextConstant.transaction_type[0], BigInt.from(0), BigInt.from(0));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             MultiProvider(
                          //                 providers: [
                          //                   ChangeNotifierProvider(create: (_) => NewTransactionProvider()
                          //                   ),
                          //                 ], child: NewTransaction(transaction: transaction))));
                          (){};
                        }),
                        statisticCard(widget.listStatistic[count].code, widget.listStatistic[count].deposit, () {
                          var transaction = Transaction("Account", widget.listStatistic[count].pool, widget.listStatistic[count].name, widget.listStatistic[count].code,
                              widget.listStatistic[count].rate,widget.listStatistic[count].icon, TextConstant.transaction_type[1], BigInt.from(0), BigInt.from(0));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             MultiProvider(
                          //                 providers: [
                          //                   ChangeNotifierProvider(create: (_) => NewTransactionProvider()
                          //                   ),
                          //                 ], child: NewTransaction(transaction: transaction))));
                              (){};
                        }),
                        statisticCard(widget.listStatistic[count].code, widget.listStatistic[count].debt, () {
                          var transaction = Transaction("Account", widget.listStatistic[count].pool, widget.listStatistic[count].name, widget.listStatistic[count].code,
                              widget.listStatistic[count].rate,widget.listStatistic[count].icon, TextConstant.transaction_type[2], BigInt.from(0), BigInt.from(0));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             MultiProvider(
                          //                 providers: [
                          //                   ChangeNotifierProvider(create: (_) => NewTransactionProvider()
                          //                   ),
                          //                 ], child: NewTransaction(transaction: transaction))));
                              (){};
                        }),
                    ]
                )
              ],
            )
          )
        ],)
    );
  }
}