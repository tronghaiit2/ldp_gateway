import 'package:flutter/material.dart';

class NewTransactionProvider extends ChangeNotifier{
  int? _amount;
  int? _fee;
  String? amountError;
  String? feeError;

  int get amount => _amount ?? 0;
  int get fee => _fee ?? 0;

  int total(){
    if(_amount != null) {
      return (_amount!);
    }
    else{
      return 0;
    }
  }

  // int total(){
  //   if(_amount != null && _fee != null) {
  //     return (_amount! + _fee!);
  //   }
  //   else{
  //     return int.from(0);
  //   }
  // }

  void editAmount(String txt){
    if(int.tryParse(txt) != null){
      _amount = int.tryParse(txt);
      amountError = null;
    }
    else {
      _amount = null;
      amountError = "Số tiền phải là số nguyên!";
    }
    notifyListeners();
  }
  void editFee(String txt, int baseFee){
    if(int.tryParse(txt) != null){
      baseFee = 0;
      if(int.tryParse(txt)! >= baseFee) {
        _fee = int.tryParse(txt);
        feeError = null;
      }
      else {
        _fee = null;
        feeError = "Phí giao dịch phải lớn hơn \$" + baseFee.toString();
      }
    }
    else {
      _fee = null;
      feeError = "Phí giao dịch phải là số nguyên!";
    }
    notifyListeners();
  }
  // bool isValid() {
  //   if (_amount != null && _fee != null) return true;
  //   return false;
  // }

  bool isValid() {
    if (_amount != null) return true;
    return false;
  }

}

