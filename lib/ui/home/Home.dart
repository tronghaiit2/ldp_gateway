import 'package:flutter/material.dart';
import 'package:ldp_gateway/ui/history/History.dart';
import 'package:ldp_gateway/ui/home/local_widgets/Statistics.dart';
import 'package:ldp_gateway/ui/home/local_widgets/Transactions.dart';
import 'package:ldp_gateway/ui/new_transactions/NewTransaction.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';

class Home extends StatefulWidget {
  late int selectedIndex;
  static const List<String> screens = [
    "Giao dịch",
    "Trang chủ",
    "Lịch sử",
  ];

  Home({required this.selectedIndex, Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
          bottomNavigationBar: buildBottomNavigation(context),
          body: widget.selectedIndex == 0
              ? Transactions()
              : widget.selectedIndex == 1
              ? Statistics()
              : History()
      ),
    );
  }

  Widget buildBottomNavigation(BuildContext context) {
    return Container(
        height: 72,
        padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.main_blue,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            color: AppColors.main_blue,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36))
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange_rounded,  size: 28),
              label: "Transaction",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_rounded, size: 28),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.content_paste, size: 28),
                label: 'History'),
          ],
          elevation: 0,
          backgroundColor: AppColors.main_blue,
          selectedItemColor: AppColors.white,
          selectedLabelStyle: TextStyle(color: AppColors.white),
          selectedFontSize: 12,
          unselectedItemColor: AppColors.white100,
          unselectedLabelStyle: TextStyle(color: AppColors.white100),
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.selectedIndex,
          onTap: (index) => setState(() {
            widget.selectedIndex = index;
          }),
        )
    );
  }
}
