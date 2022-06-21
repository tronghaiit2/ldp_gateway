import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
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
  final List<Statistic> listStatistic;

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
    aCoinList = {
      "Gửi" : ["1000", 'assets/images/main_icon.png', "/workdaystatistics"],
      "Mượn" : ["1000", 'assets/images/main_icon.png',"/absentstatistics"],
      "Trả" : ["1000",'assets/images/main_icon.png',"/arrivelatestatistics"],
      "Rút" : ["1000",'assets/images/main_icon.png',"/leavesoonstatistics"],
    };

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
              width: 80,
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text("No. " + count.toString(), textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: AppColors.blue, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis, maxLines: 2,),
            ),
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Image.asset(widget.listStatistic[count].coin_icon, height: 80, width: 80, fit: BoxFit.fill),
            ),
          ],),
          Expanded(child: GridView.count(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              scrollDirection: Axis.vertical,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              shrinkWrap: true,
              primary: false,
              childAspectRatio: 3,
              crossAxisCount: ResponsiveLayout.issmartphone(context) ? 2 : ResponsiveLayout.istablet(context) ? 4 : 5,
              children:
              [
                for(int i = 0; i < 4; i++)
                  statisticCard(TextContant.transaction_type[i], widget.listStatistic[count].deposit, () {
                    var transaction = Transaction("Account", widget.listStatistic[count].pool, widget.listStatistic[count].coin_name, widget.listStatistic[count].coin_code,
                        widget.listStatistic[count].coin_rate,widget.listStatistic[count].coin_icon, TextContant.transaction_type[i], 0, 0);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(create: (_) => NewTransactionProvider()
                                      ),
                                    ], child: NewTransaction(transaction: transaction))));
                  }),
              ]
          ))
        ],)
    );
  }
}