import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? smartphone;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({Key? key, this.smartphone, this.tablet, this.desktop,
  }) : super(key: key);
  static int smartphoneLimit = 500;
  static int tabletLimit = 1000;
  static bool issmartphone(
      BuildContext context) => MediaQuery.of(context).size.width < smartphoneLimit;
  static bool istablet(
      BuildContext context) => MediaQuery.of(context).size.width < tabletLimit
      && MediaQuery.of(context).size.width >= smartphoneLimit;
  static bool isdesktop(
      BuildContext context) => MediaQuery.of(context).size.width >= tabletLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletLimit) {
          return desktop!;
        } else if (constraints.maxWidth >= smartphoneLimit) {
          return tablet!;
        } else {
          return smartphone!;
        }
      },
    );
  }
}