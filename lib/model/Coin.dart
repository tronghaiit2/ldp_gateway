import 'package:flutter/material.dart';

class Coin {
  late String pool;
  late String name;
  late String code;
  late double rate;
  late double total;
  late double available;
  late double used;
  late String icon;

  Coin(
      this.pool,
      this.name,
      this.code,
      this.rate,
      this.total,
      this.available,
      this.used,
      this.icon
      );
}

