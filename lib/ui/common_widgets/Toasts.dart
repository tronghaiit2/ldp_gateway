import 'package:fluttertoast/fluttertoast.dart';
import 'package:ldp_gateway/main.dart';

import 'package:ldp_gateway/utils/constant/ColorConstant.dart';

showToast(String content){
  if(LDPGateway.isShowingToast == true){

  }
  else {
    LDPGateway.isShowingToast = true;
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.inputBorder,
        textColor: AppColors.white,
        fontSize: 14
    );  
    Future.delayed(Duration(seconds: 5), (){
      LDPGateway.isShowingToast = false;
    });
  }
}
