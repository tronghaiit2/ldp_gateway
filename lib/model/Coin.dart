import 'package:flutter/material.dart';

class Coin {
  late String pool;
  late String name;
  late String code;
  late double rate;
  late BigInt balance;
  late BigInt deposit;
  late BigInt debt;
  late String icon;

  Coin(
      this.pool,
      this.name,
      this.code,
      this.rate,
      this.balance,
      this.deposit,
      this.debt,
      this.icon
      );
}

