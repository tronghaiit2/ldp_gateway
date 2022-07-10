import 'package:flutter/material.dart';

class NewTransactionProvider extends ChangeNotifier{
  BigInt? _amount;
  BigInt? _fee;
  String? amountError;
  String? feeError;

  BigInt get amount => _amount ?? BigInt.from(0);
  BigInt get fee => _fee ?? BigInt.from(0);

  BigInt total(){
    if(_amount != null) {
      return (_amount!);
    }
    else{
      return BigInt.from(0);
    }
  }

  // BigInt total(){
  //   if(_amount != null && _fee != null) {
  //     return (_amount! + _fee!);
  //   }
  //   else{
  //     return BigInt.from(0);
  //   }
  // }

  void editAmount(String txt){
    if(BigInt.tryParse(txt) != null){
      _amount = BigInt.tryParse(txt);
      amountError = null;
    }
    else {
      _amount = null;
      amountError = "Số tiền phải là số nguyên!";
    }
    notifyListeners();
  }
  void editFee(String txt, BigInt baseFee){
    if(BigInt.tryParse(txt) != null){
      baseFee = BigInt.from(0);
      if(BigInt.tryParse(txt)! >= baseFee) {
        _fee = BigInt.tryParse(txt);
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

