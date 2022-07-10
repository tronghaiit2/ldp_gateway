import 'package:flutter/material.dart';
import 'package:ldp_gateway/model/Transaction.dart';
import 'package:ldp_gateway/ui/history/local_widgets/detailHistory.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late List<Transaction> listTransaction = [
    Transaction("Account", "Compound", "Bitcoin", "BTC", 19039.23, "assets/images/coins/bitcoin.png", "GỬI",  BigInt.from(0), BigInt.from(0)),
    Transaction("Account", "Aave", "BNB", "BNB", 200.23, "assets/images/coins/bnb.png", "TRẢ",  BigInt.from(0), BigInt.from(0)),
    Transaction("Account", "Compound", "Ethereum", "ETH", 998.02, "assets/images/coins/ethereum.png", "RÚT",  BigInt.from(0), BigInt.from(0)),
    Transaction("Account", "Aave", "BNB", "BNB", 200.23, "assets/images/coins/bnb.png", "MƯỢN", BigInt.from(0), BigInt.from(0)),
    Transaction("Account", "Compound", "Ethereum", "ETH", 998.02, "assets/images/coins/ethereum.png", "TRẢ",  BigInt.from(0), BigInt.from(0)),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        toolbarHeight: 50,
        title: Text("Transaction History", style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.main_blue)),
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for(int i = 0; i < listTransaction.length; i++)
                  detailHistory(listTransaction[i])
              ],
            ),
          )
      ),
    );
  }
}