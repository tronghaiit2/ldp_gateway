import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ldp_gateway/ui/login/local_widgets/LoginScreen.dart';

import 'package:ldp_gateway/provider/login/AuthProvider.dart';
import 'package:ldp_gateway/provider/login/LoginProvider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return  MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()
            ),
            ChangeNotifierProvider(create: (_) => LoginProvider()
            ),
          ], child: LoginScreen()
    );
  }
}
