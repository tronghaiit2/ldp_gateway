import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:ldp_gateway/route.dart';

import 'package:ldp_gateway/ui/common_widgets/ResponsiveLayout.dart';
import 'package:ldp_gateway/utils/PushNotifications.dart';

import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:ldp_gateway/utils/share_preferences/login/UserPreferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool first = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!first) {
      first = true;
      _navigate();
    }
  }

  @override
  Widget build(BuildContext context) {
    if(ResponsiveLayout.issmartphone(context)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
       child: Container(
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/Logo.png",
                fit: BoxFit.fill,
              ),
              const SpinKitCircle(
                color: AppColors.main_red,
                size: 50,
              )
            ],
          ),
        )
    );
  }

  _navigate() async {
    //await initializeService();
    String? token = await UserPreferences().token;
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.login, (Route<dynamic> route) => false);
  }
}
