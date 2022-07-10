import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldp_gateway/blockchain/contracts/debt_token/aave_debt_token.dart';
import 'package:ldp_gateway/blockchain/contracts/ierc20.dart';
import 'package:ldp_gateway/main.dart';
import 'package:ldp_gateway/model/Coin.dart';
import 'package:ldp_gateway/model/Statistic.dart';
import 'package:ldp_gateway/route.dart';
import 'package:ldp_gateway/ui/home/local_widgets/StatisticsTab.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:ldp_gateway/utils/constant/TextConstant.dart';
import 'package:ldp_gateway/utils/share_preferences/login/UserPreferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:web3dart/web3dart.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int _initialized = 0;

  late String address = 'address';
  late BigInt amount;
  late String token = 'token';

  late List<Coin> compoundList = [];
  late List<Coin> aaveList = [];

  @override
  void initState() {
    super.initState();
    getData();
    getStatisticData();
  }


  Future<void> getData() async {
    address = (await LDPGateway.client!.credentials.extractAddress()).toString();
    amount = (await LDPGateway.client!.getBalance()).getInEther;
    token = (await UserPreferences().privatekey)!;
    if(mounted){
      setState(() {
        _initialized = 1;
      });
    }
  }

  Future<void> getStatisticData() async {
    aaveList.clear();
    int len = TextConstant.coinCodeList.length;
    int i = 0;
    for(i = 0; i < len; i++){
      String code = TextConstant.coinCodeList[i];
      String name = TextConstant.coinNameList[TextConstant.coinCodeList[i]] ?? "";
      String icon = TextConstant.coinIconList[TextConstant.coinCodeList[i]] ?? "";
      IERC20 coin = IERC20(TextConstant.aaveTokenList[TextConstant.coinCodeList[i]] ?? "", LDPGateway.client!);

      EthereumAddress aCoinAddress = await LDPGateway.poolGW.getReverse("Aave", TextConstant.aaveTokenList[TextConstant.coinCodeList[i]] ?? "");
      IERC20 aCoin = IERC20(aCoinAddress.hex, LDPGateway.client!);

      EthereumAddress debtCoinAddress = await LDPGateway.poolGW.getDebt("Aave", TextConstant.aaveTokenList[TextConstant.coinCodeList[i]] ?? "");
      AaveDebtToken debtCoin = AaveDebtToken(debtCoinAddress.hex, LDPGateway.client!);

      final firstCoinBalance = await coin.checkBalance();
      final firstACoinBalance = await aCoin.checkBalance();
      final firstDebtBalance = await debtCoin.checkBalance();

      if(firstCoinBalance != BigInt.from(0) || firstACoinBalance != BigInt.from(0) || firstDebtBalance != BigInt.from(0)) {
        aaveList.add(Coin("Aave", name, code, 0, firstCoinBalance.toInt(), firstACoinBalance.toInt(), firstDebtBalance.toInt(), icon));
      }
    }

    // for(i = 0; i < len; i++){
    //   String code = TextConstant.coinCodeList[i];
    //   String name = TextConstant.coinNameList[TextConstant.coinCodeList[i]] ?? "";
    //   String icon = TextConstant.coinIconList[TextConstant.coinCodeList[i]] ?? "";
    //
    //   IERC20 coin = IERC20(TextConstant.compoundTokenList[TextConstant.coinCodeList[i]] ?? "", LDPGateway.client!);
    //
    //   EthereumAddress aCoinAddress = await LDPGateway.poolGW.getReverse("Compound", TextConstant.compoundTokenList[TextConstant.coinCodeList[i]] ?? "");
    //   IERC20 aCoin = IERC20(aCoinAddress.hex, LDPGateway.client!);
    //
    //   EthereumAddress debtCoinAddress = await LDPGateway.poolGW.getDebt("Compound", TextConstant.compoundTokenList[TextConstant.coinCodeList[i]] ?? "");
    //   AaveDebtToken debtCoin = AaveDebtToken(debtCoinAddress.hex, LDPGateway.client!);
    //
    //   final firstCoinBalance = await coin.checkBalance();
    //   final firstACoinBalance = await aCoin.checkBalance();
    //   final firstDebtBalance = await debtCoin.checkBalance();
    //
    //   compoundList.add(Coin("Compound", name, code, 0, firstCoinBalance, firstACoinBalance, firstDebtBalance, icon));
    // }

    if(i >= len) {
      if(mounted) {
        setState(() {
          _initialized = 2;
        });
      }
    }
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
        body:
        _initialized == 0 ? const Center(
          child: SpinKitCircle(
            color: AppColors.red,
            size: 50,
          ),
        ) :
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            headerInformation(),
            tabBarLabel(),
            Expanded(
                child:
                _initialized  == 2 ?TabBarView(
                  children: [
                    StatisticsTab(statistic_type: 1, listStatistic: aaveList),
                    StatisticsTab(statistic_type: 2, listStatistic: compoundList),
                  ],
                ) : const Center(
                  child: SpinKitCircle(
                    color: AppColors.red,
                    size: 50,
                  ),
                )
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
            Text(address.substring(0,5) + '...' + address.substring(address.length - 5,address.length), textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.blue,),
                overflow: TextOverflow.ellipsis),
            Text(amount.toString() + ' ETH', textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.main_blue,),
                overflow: TextOverflow.ellipsis),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(token.substring(0,4) + '...' + token.substring(token.length - 4,token.length), textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black,),
                    overflow: TextOverflow.ellipsis),
                SizedBox(width: 5),
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.copy_rounded,
                  color: AppColors.checkboxBorder,
                  size: 20,
                ),)
              ]
            )
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
            text: TextConstant.pools[1]!,
          ),
          Tab(
            text: TextConstant.pools[2]!,
          ),
        ],
      ),
    );
  }
}

