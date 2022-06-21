/*This file contains all the routes for this application.*/
import 'package:flutter/material.dart';

import 'package:ldp_gateway/ui/login/Login.dart';
import 'package:ldp_gateway/ui/home/Home.dart';
import 'package:ldp_gateway/ui/history/History.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = "/login";

  static const String home0 = "/home0";
  static const String home1 = "/home1";
  static const String home2 = "/home2";

  static const String history = "/history";

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => Login(),

    home0: (BuildContext context) => Home(selectedIndex: 0),
    home1: (BuildContext context) => Home(selectedIndex: 1),
    home2: (BuildContext context) => Home(selectedIndex: 2),

    history: (BuildContext context) => History(),
  };
}
