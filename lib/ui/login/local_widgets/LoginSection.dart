import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:ldp_gateway/blockchain/address.dart';
import 'package:ldp_gateway/blockchain/contracts/pool_gw.dart';
import 'package:ldp_gateway/blockchain/eth_client.dart';
import 'package:ldp_gateway/main.dart';
import 'package:provider/provider.dart';

import 'package:ldp_gateway/route.dart';
import 'package:ldp_gateway/utils/PushNotifications.dart';

import 'package:ldp_gateway/utils/constant/ColorConstant.dart';
import 'package:ldp_gateway/utils/constant/TextConstant.dart';
import 'package:ldp_gateway/utils/share_preferences/login/UserPreferences.dart';
import 'package:ldp_gateway/utils/share_preferences/login/AccountPreferences.dart';

import 'package:ldp_gateway/ui/common_widgets/InputDecoration.dart';
import 'package:ldp_gateway/ui/common_widgets/Buttons.dart';
import 'package:ldp_gateway/ui/common_widgets/ResponsiveLayout.dart';
import 'package:ldp_gateway/ui/common_widgets/CheckBox.dart';
import 'package:ldp_gateway/ui/common_widgets/NotificationDialog.dart';

import 'package:ldp_gateway/provider/login/AuthProvider.dart';
import 'package:ldp_gateway/provider/login/LoginProvider.dart';
import 'package:web3dart/web3dart.dart';


class LoginSection extends StatefulWidget {
  const LoginSection({Key? key}) : super(key: key);
  static int alertDialogCount = 0;

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  late AuthProvider _authProvider;
  late LoginProvider _loginProvider;
  late String token;
  late bool isChecked = false;
  late List<String> accountList = [];
  
  @override
  initState() {
    super.initState();
    AccountPreferences().getAllAccount().then((allAccount) => accountList = allAccount);
  }

  @override
  void didChangeDependencies() {
    _authProvider = Provider.of(context);
    _loginProvider =  Provider.of(context);
    super.didChangeDependencies();
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return AppColors.checkboxBorder;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Column(children: [
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   alignment: Alignment.topCenter,
          //   child:  Image.asset('assets/icons/vn.png',width: 50, height: 50, fit: BoxFit.fill),
          // ),
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            child: ResponsiveLayout(
              smartphone: Image.asset('assets/images/Logo.png', width: 200),
              tablet: Image.asset('assets/images/Logo.png', width: 320),
              desktop: Image.asset('assets/images/Logo.png'),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 50, bottom: 50),
              alignment: Alignment.topCenter,
              child: Text("Đăng nhập", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontSize: 40, color: AppColors.main_blue))
          ),
          Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // account(screenWidth),
                password(),
                // rememberMe()
              ],
            ),
          ),
          SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: selectButton("ĐĂNG NHẬP", (){
                  if(_authProvider.isValid()) {
                    _login();
                  }
                  else{
                    if(LoginSection.alertDialogCount == 0){
                      LoginSection.alertDialogCount++;
                      showWarningDialog("Hãy nhập các trường bỏ trống", context, (){
                        if(LoginSection.alertDialogCount > 0) LoginSection.alertDialogCount = 0;
                      });
                    }
                  }
                }),
              )
          ),
        ]),
    );
  }

  Autocomplete account(double screenWidth){
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue){
        if(textEditingValue.text.isEmpty){
          return accountList;
        }
        else{
          return accountList.where((word) =>
              word.toLowerCase().contains(textEditingValue.text.toLowerCase()));
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
                    margin: EdgeInsets.only(right: ResponsiveLayout.issmartphone(context)? screenWidth*0.2 : ResponsiveLayout.istablet(context)?screenWidth*0.5 : screenWidth*0.6),
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
        _authProvider.editUser(selectedString.toString());
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete){
        return TextField(
          controller: controller,
          focusNode: focusNode,
          //onEditingComplete: onEditingComplete,
          style: TextStyle(fontSize: 20, color: Colors.black),
          cursorColor: AppColors.checkboxBorder,
          keyboardType: TextInputType.text,
          decoration: textFieldInputDecoration('Tên đăng nhập', 'Tên đăng nhập', _authProvider.userError),
          onChanged: (value) {
            _authProvider.editUser(value);
          },
        );
      },
    );
  }

  Stack password(){
    return Stack(children: [
      TextField(
        style: TextStyle(fontSize: 20, color: Colors.black),
        obscureText: _loginProvider.visible,
        cursorColor: AppColors.checkboxBorder,
        keyboardType: TextInputType.text,
        decoration: textFieldvsIconInputDecoration('Mật khẩu', 'Mật khẩu', _authProvider.passwordError, _loginProvider.visible, (){
          _loginProvider.setVisible();
        }),
        onChanged: (value) {
          _authProvider.editPassword(value);
        },
      ),
      // Align(
      //   alignment: Alignment.bottomRight,
      //   child: TextButton(
      //       onPressed: (){
      //       },
      //       child: Text("Quên mật khẩu", style: TextStyle(fontSize: 18, color: AppColors.main_red))
      //   ),
      // ),
    ],);
  }

  Row rememberMe(){
    return Row(children: [
      SizedBox(
          height: 24.0,
          width: 24.0,
          child: Theme(
            data: ThemeData(
                unselectedWidgetColor: AppColors.white
            ),
            child: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          )),
      SizedBox(width: 5),
      InkWell(
        onTap: (){
          setState(() {
            isChecked = isChecked? false : true;
          });
        },
        child: Text("Nhớ đăng nhập", style: TextStyle(fontSize: 16, color: Colors.black)),
      ),
    ]);
  }

  void _login() async {
    try {
      LDPGateway.client = EthClient(_authProvider.password!, Address.RPC_URL);
      if(LDPGateway.client == null) {
        if(LoginSection.alertDialogCount == 0){
          LoginSection.alertDialogCount++;
          showWarningDialog("Private key không đúng!", context, (){
            if(LoginSection.alertDialogCount > 0) LoginSection.alertDialogCount = 0;
          });
        }
      } else {
        EtherAmount etherAmount = await LDPGateway.client!.getBalance();
        if(etherAmount.getInEther != 0) {
          print("ok");
          await UserPreferences().savePrivatekey(_authProvider.password!);
          LDPGateway.poolGW = PoolGW(Address.POOL_GW, LDPGateway.client!);
          Address.POOL["Aave"] = (await LDPGateway.poolGW.getGatewayAddress("Aave")).hex;
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home1, (Route<dynamic> route) => false);
        }
        else {
          print("none");
          if(LoginSection.alertDialogCount == 0){
            LoginSection.alertDialogCount++;
            showWarningDialog("Private key không đúng!", context, (){
              if(LoginSection.alertDialogCount > 0) LoginSection.alertDialogCount = 0;
            });
          }
        }
      }
    }
    on Exception catch(_){
      if(LoginSection.alertDialogCount == 0){
        LoginSection.alertDialogCount++;
        showWarningDialog("Private key không đúng!", context, (){
          if(LoginSection.alertDialogCount > 0) LoginSection.alertDialogCount = 0;
        });
      }
    }
  }
}
