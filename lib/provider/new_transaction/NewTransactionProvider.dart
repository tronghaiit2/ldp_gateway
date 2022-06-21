import 'package:flutter/material.dart';

class NewTransactionProvider extends ChangeNotifier{
  double? _amount;
  double? _fee;
  String? amountError;
  String? feeError;

  double get amount => _amount ?? 0;
  double get fee => _fee ?? 0;

  double total(){
    if(_amount != null && _fee != null) {
      return (_amount! + _fee!);
    }
    else{
      return 0;
    }
  }

  void editAmount(String txt){
    if(double.tryParse(txt) != null){
      _amount = double.tryParse(txt);
      amountError = null;
    }
    else {
      _amount = null;
      amountError = "Số tiền phải là số thực!";
    }
    notifyListeners();
  }
  void editFee(String txt, double baseFee){
    if(double.tryParse(txt) != null){
      if(double.tryParse(txt)! >= baseFee) {
        _fee = double.tryParse(txt);
        feeError = null;
      }
      else {
        _fee = null;
        feeError = "Phí giao dịch phải lớn hơn \$" + baseFee.toString();
      }
    }
    else {
      _fee = null;
      feeError = "Phí giao dịch phải là số thực!";
    }
    notifyListeners();
  }
  bool isValid() {
    if (_amount != null && _fee != null) return true;
    return false;
  }

}

