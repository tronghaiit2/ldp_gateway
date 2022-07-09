import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ldp_gateway/blockchain/contracts/pool_gw.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/route.dart';
import 'package:ldp_gateway/splash_screen.dart';
import 'package:ldp_gateway/utils/constant/ColorConstant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LDPGateway());
}

class LDPGateway extends StatelessWidget {
  const LDPGateway({Key? key}) : super(key: key);

  static EthClient? client;
  static late PoolGW poolGW;

  static bool isShowingToast = false;
  static bool onlyMe = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: null,
      statusBarColor: AppColors.gray,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
        title: 'LenDing Pool Gateway',
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('vi', 'VN'), Locale('en', 'US')],
        theme: ThemeData(
          fontFamily: 'Averta',
          primarySwatch: appSwatch,
        ),
        routes: Routes.routes,
        home: SplashScreen());
  }
}
