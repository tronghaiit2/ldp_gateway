import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ldp_gateway/utils/constant/ColorConstant.dart';

import 'package:ldp_gateway/ui/login/local_widgets/LoginSection.dart';
import 'package:ldp_gateway/ui/common_widgets/ResponsiveLayout.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, right: 20),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.settings_rounded, color: AppColors.checkboxBorder, size: 32),
                    onPressed: () => {

                    },
                  ),
                ),
                ResponsiveLayout(
                  smartphone: Container(
                    padding: EdgeInsets.only(left: screenWidth*0.1, right: screenWidth*0.1),
                    child: LoginSection(),
                  ),
                  tablet: Container(
                    padding: EdgeInsets.only(left: screenWidth*0.25, right: screenWidth*0.25),
                    child: LoginSection(),
                  ),
                  desktop: Container(
                    padding: EdgeInsets.only(left: screenWidth*0.3, right: screenWidth*0.3),
                    child: LoginSection(),
                  ),),
              ],
            )
        )
    );
  }
}
