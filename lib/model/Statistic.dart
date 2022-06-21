import 'package:flutter/material.dart';

class Statistic {
  late String account;
  late String pool;
  late String coin_name;
  late String coin_code;
  late double coin_rate;
  late String coin_icon;
  late double deposit;
  late double borrow;
  late double repay;
  late double withdraw;

  Statistic(
      this.account,
      this.pool,
      this.coin_name,
      this.coin_code,
      this.coin_rate,
      this.coin_icon,
      this.deposit,
      this.borrow,
      this.repay,
      this.withdraw,
      );
}

