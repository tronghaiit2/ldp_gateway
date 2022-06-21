import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldp_gateway/model/Statistic.dart';
import 'package:ldp_gateway/route.dart';
import 'package:ldp_gateway/ui/home/local_widgets/StatisticsTab.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late String address = 'address';
  late double amount = 100000;
  late String token = 'token';

  late Map<int, String> pools = {
    1 : "Compound",
    2 : "Aave",
  };

  late List<Statistic> compoundList = [
    Statistic("address", "Compound", "Bitcoin", "BTC", 19039.23, "assets/images/coins/bitcoin.png", 0, 0, 0, 0),
    Statistic("address", "Compound", "Ethereum", "ETH", 998.02, "assets/images/coins/ethereum.png", 0, 0, 0, 0),
  ];

  late List<Statistic> aaveList = [
    Statistic("address", "Aave", "Bitcoin", "BTC", 19039.23, "assets/images/coins/bitcoin.png", 0, 0, 0, 0),
    Statistic("address", "Aave", "BNB", "BNB", 200.23, "assets/images/coins/bnb.png", 0, 0, 0, 0),
  ];

  @override
  void initState() {
    super.initState();
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.main_blue;
    }
    return AppColors.main_blue;
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 50,
            child: Image.asset('assets/images/Logo.png')
          ),
          actions:
          <Widget>[
            IconButton(onPressed: (){},
                padding: EdgeInsets.only(right: 20),
                icon: Icon(Icons.menu_rounded, size: 32, color: AppColors.blue,))
          ],
          centerTitle: false,
          backgroundColor: AppColors.white,
          toolbarHeight: 50,
          leadingWidth: 0,
          elevation: 1,
          // give the app bar rounded corners
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            headerInformation(),
            tabBarLabel(),
            Expanded(
              child: TabBarView(
                children: [
                  StatisticsTab(statistic_type: 0, listStatistic: compoundList),
                  StatisticsTab(statistic_type: 1, listStatistic: aaveList),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container headerInformation(){
    return Container(
        height: 250,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.inputBorder,
                blurRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
            color: AppColors.white,
        ),
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.red50,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              padding: EdgeInsets.all(10),
              child: CircleAvatar(foregroundImage: AssetImage('assets/images/home_image.jpg')),
            ),
            Text(address, textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.blue,),
                overflow: TextOverflow.ellipsis),
            Text('\$' + amount.toString(), textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.main_blue,),
                overflow: TextOverflow.ellipsis),
            Text(token, textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, color: Colors.black,),
              overflow: TextOverflow.ellipsis, maxLines: 2,),
          ],
        )
    );
  }

  Container tabBarLabel(){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.inputBorder,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(
          0.0,
        ),
      ),
      margin: EdgeInsets.only(left: 0,right: 0),
      child: TabBar(
        labelStyle: TextStyle(fontSize: 16),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: AppColors.main_blue
        ),
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.checkboxBorder,
        tabs: [
          Tab(
            text: pools[1]!,
          ),
          Tab(
            text: pools[2]!,
          ),
        ],
      ),
    );
  }
}

