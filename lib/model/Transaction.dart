import 'package:flutter/material.dart';

class Transaction {
  late String account;
  late String pool;
  late String coin_name;
  late String coin_code;
  late double coin_rate;
  late String coin_icon;
  late String type;
  late BigInt amount;
  late BigInt fee;

  Transaction(
      this.account,
      this.pool,
      this.coin_name,
      this.coin_code,
      this.coin_rate,
      this.coin_icon,
      this.type,
      this.amount,
      this.fee
  );
}

