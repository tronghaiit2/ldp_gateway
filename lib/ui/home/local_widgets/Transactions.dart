import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldp_gateway/model/Coin.dart';
import 'package:ldp_gateway/model/Transaction.dart';
import 'package:ldp_gateway/provider/new_transaction/NewTransactionProvider.dart';
import 'package:ldp_gateway/route.dart';
import 'package:ldp_gateway/ui/common_widgets/Buttons.dart';
import 'package:ldp_gateway/ui/common_widgets/InputDecoration.dart';
import 'package:ldp_gateway/ui/common_widgets/NotificationDialog.dart';
import 'package:ldp_gateway/ui/common_widgets/ResponsiveLayout.dart';
import 'package:ldp_gateway/ui/new_transactions/NewTransaction.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:ldp_gateway/utils/constant/TextConstant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);
  static int alertDialogCount = 0;

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late Map<int, String> pools = {
    1 : "Compound",
    2 : "Aave",
  };
  late int id_selected = 0;
  late String pool_selected = "";

  late List<Coin> allCoin = [
    Coin("Compound", "Bitcoin", "BTC", 19039.23, 0, 0, 0, "assets/images/coins/bitcoin.png"),
    Coin("Compound", "Ethereum", "ETH", 998.02, 0, 0, 0, "assets/images/coins/ethereum.png"),
    Coin("Compound", "BNB", "BNB", 200.23, 0, 0, 0, "assets/images/coins/bnb.png"),
    Coin("Aave", "Bitcoin", "BTC", 19039.23, 0, 0, 0, "assets/images/coins/bitcoin.png"),
    Coin("Aave", "Ethereum", "ETH", 998.02, 0, 0, 0, "assets/images/coins/ethereum.png"),
    Coin("Aave", "BNB", "BNB", 200.23, 0, 0, 0, "assets/images/coins/bnb.png"),
  ];

  late List<Coin> coinList = [];
  late String _searchResult = "";

  late int selected_coin = 0;
  late int _max = coinList.length;
  late CarouselController _controller = CarouselController();

  late int selected_transaction = -1;

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

  Future<void> getData() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
              id_selected != 0 ?
              <Widget>[
                selectCoin(),
                searchCoin(),
                coinCarousel(),
                selectTransaction(),
                SafeArea(
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
                      child: selectButton("BẮT ĐẦU GIAO DỊCH", (){
                        if(selected_transaction == -1) {
                          if(Transactions.alertDialogCount == 0){
                            Transactions.alertDialogCount++;
                            showWarningDialog("Hãy lựa chọn giao dịch!", context, (){
                              if(Transactions.alertDialogCount > 0) Transactions.alertDialogCount = 0;
                            });
                          }
                        }
                        else{
                          var transaction = Transaction("Account", pool_selected, coinList[selected_coin].name, coinList[selected_coin].code,
                              coinList[selected_coin].rate, coinList[selected_coin].icon, TextContant.transaction_type[selected_transaction], 0, 0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MultiProvider(
                                          providers: [
                                            ChangeNotifierProvider(create: (_) => NewTransactionProvider()
                                            ),
                                          ], child: NewTransaction(transaction: transaction))));
                        }
                      }),
                    )
                ),
              ] : <Widget>[
                selectCoin(),
              ],
          ),
        ),
    );
  }

  Container selectCoin(){
    return Container(
        height: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.inputBorder,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          color: AppColors.gray,
        ),
        padding: EdgeInsets.only(top: 20, bottom: 20),
        margin: EdgeInsets.only(bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Lending Pool', textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.main_blue,),
                overflow: TextOverflow.ellipsis),
            Container(
              height: 120,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: RefreshIndicator(
                  displacement: 0,
                  color: AppColors.red,
                  onRefresh: getData,
                  child: ListView(
                    children: pools.keys.map((int key) {
                      return RadioListTile<int>(
                          activeColor: AppColors.red,
                          title: Text(pools[key]!, style: TextStyle(fontSize: 20)),
                          value: key,
                          groupValue: id_selected,
                          onChanged: (int? value) {
                            setState(() {
                              id_selected = value ?? id_selected;
                              pool_selected = pools[key]!;
                              coinList.clear();
                              for(var coin in allCoin) {
                                if(coin.pool == pool_selected) {
                                  coinList.add(coin);
                                }
                              }
                            });
                          }
                      );
                    }).toList(),
                  )
              ),
            ),
          ],
        )
    );
  }

  Autocomplete searchCoin(){
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue){
        if(textEditingValue.text.isEmpty){
          return coinList.map((coin) => coin.name);
        }
        else{
          return coinList.map((coin) => coin.name).where((name) =>
              name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
        }
      },
      optionsViewBuilder: (context, Function(String) onSelected, options){
        return Align(
            alignment: Alignment.topCenter,
            child: Container(
                height: options.length < 5 ? options.length*60 : 250,
                constraints: BoxConstraints(maxHeight: 250),
                color: Colors.transparent,
                child: Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.white100, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);
                          return ListTile(
                            hoverColor: AppColors.inputBorder,
                            title: Text(option.toString(), style: const TextStyle(fontSize: 20)),
                            onTap: (){
                              onSelected(option.toString());
                            },
                          );
                        },
                        separatorBuilder:(BuildContext context, int index) => const Divider(),
                        itemCount: options.length
                    )
                ))
        );
      },
      onSelected: (selectedString) {
        setState(() {
          _searchResult = selectedString.toString();
          for (int i = 0; i <= _max; i++) {
            if(coinList[i].name == _searchResult) {
              selected_coin = i;
              _controller.jumpToPage(i);
            }
          }
        });
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete){
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          style: TextStyle(fontSize: 20, color: Colors.black),
          cursorColor: AppColors.checkboxBorder,
          keyboardType: TextInputType.text,
          decoration: textFieldSearchDecoration("Tìm kiếm coin", (){
            setState(() {
              controller.clear();
              _searchResult = "";
            });
          }),
          onChanged: (value) {
              _searchResult = value;
          },
        );
      },
    );
  }
  Container coinCarousel(){
    return Container(
      child: Column(children: [
        CarouselSlider(
          items: coinList.map((coin) => coinInformation(coin)).toList(),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 0.8,
              enlargeCenterPage: false,
              pageSnapping: true,
              aspectRatio: 1.75,
              onPageChanged: (index, reason) {
                setState(() {
                  selected_coin = index;
                });
              }),
        ),
        Text((selected_coin+1).toString() + "/" + _max.toString(), textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.main_blue,),
            overflow: TextOverflow.ellipsis),
      ]),
    );
  }


  Container coinInformation(Coin coin) {
    return Container(
        width: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.inputBorder,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
          color: AppColors.gray,
        ),
        padding: EdgeInsets.only(top: 10, bottom: 5),
        margin: EdgeInsets.only(bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(coin.name, textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.main_blue,),
                overflow: TextOverflow.ellipsis),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blue,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                  foregroundImage: AssetImage(coin.icon)),
            ),
            GridView.count(
              primary: false,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: 2,
              childAspectRatio: 5,
              children: <Widget>[
                Text('Khả dụng', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,),
                    overflow: TextOverflow.ellipsis),
                Text('Đã dùng', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,),
                    overflow: TextOverflow.ellipsis),
                Text('\$'+coin.available.toString(), textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.red200,),
                    overflow: TextOverflow.ellipsis),
                Text('\$'+coin.used.toString(), textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.red150,),
                    overflow: TextOverflow.ellipsis),
              ],
            )
          ],
        )
    );
  }

  Container selectTransaction(){
    return Container(
        height: 100,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Chọn giao dịch', textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blue,),
                overflow: TextOverflow.ellipsis),
            GridView.count(
              primary: false,
              padding: EdgeInsets.all(5),
              shrinkWrap: true,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 4,
              childAspectRatio: 2.5,
              children: <Widget>[
                for (var i=0; i<4; i++)
                  selected_transaction == i ? selectedButton(TextContant.transaction_type[i],  (){
                    setState(() {
                      selected_transaction = -1;
                    });
                  }) : unSelectedButton(TextContant.transaction_type[i],  (){
                    setState(() {
                      selected_transaction = i;
                    });
                  }),
              ],
            )
          ],
        )
    );
  }
}

