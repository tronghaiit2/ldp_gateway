import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ldp_gateway/main.dart';
import 'package:ldp_gateway/model/Transaction.dart';
import 'package:ldp_gateway/ui/history/local_widgets/detailHistory.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:ldp_gateway/utils/sqflite_db/transaction_history_db.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late List<aTransaction> listTransaction = [];

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    String address = (await LDPGateway.client!.credentials.extractAddress()).toString();
    listTransaction = await DBProvider.dbase.getAllTransactions(address);
    if(mounted){
      setState(() {
        _initialized = true;
      });
    }
  }
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
      body:
      _initialized == 0 ? const Center(
        child: SpinKitCircle(
          color: AppColors.red,
          size: 50,
        ),
      ) :
        Container(
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