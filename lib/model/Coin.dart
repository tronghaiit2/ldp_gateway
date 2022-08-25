import 'package:flutter/material.dart';

class Coin {
  int? _id;
  late String _account;
  late String _pool;
  late String _coin_name;
  late String _coin_code;
  late double _coin_rate;
  late String _coin_icon;
  late int _balance;
  late int _deposit;
  late int _debt;

  Coin({
  int? id,
    required String account,
    required String pool,
    required String coin_name,
    required String coin_code,
    required double coin_rate,
    required String coin_icon,
    required int balance,
    required int deposit,
    required int debt,
  }) {
    this._id = id;
    this._account = account;
    this._pool = pool;
    this._coin_name = coin_name;
    this._coin_code = coin_code;
    this._coin_rate = coin_rate;
    this._coin_icon = coin_icon;
    this._balance = balance;
    this._deposit = deposit;
    this._debt = debt;
  }

  int? get id => this._id;
  set id(int? id) => this._id = id;
  String get account => this._account;
  set account(String account) => this._account = account;
  String get pool => this._pool;
  set pool(String pool) => this._pool = pool;
  String get coin_name => this._coin_name;
  set coin_name(String coin_name) => this._coin_name = coin_name;
  String get coin_code => this._coin_code;
  set coin_code(String coin_code) => this._coin_code = coin_code;
  double get coin_rate => this._coin_rate;
  set coin_rate(double coin_rate) => this._coin_rate = coin_rate;
  String get coin_icon => this._coin_icon;
  set coin_icon(String coin_icon) => this._coin_icon = coin_icon;
  int get balance => this._balance;
  set balance(int balance) => this._balance = balance;
  int get deposit => this._deposit;
  set deposit(int deposit) => this._deposit = deposit;
  int get debt => this._debt;
  set debt(int debt) => this._debt = debt;


  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['account'] = this.account;
  data['pool'] = this.pool;
  data['coin_name'] = this.coin_name;
  data['coin_code'] = this.coin_code;
  data['coin_rate'] = this.coin_rate;
  data['coin_icon'] = this.coin_icon;
  data['balance'] = this.balance;
  data['deposit'] = this.deposit;
  data['debt'] = this._debt;
  return data;
  }

  Coin.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _account = json['account'];
    _pool = json['pool'];
    _coin_name = json['coin_name'];
    _coin_code = json['coin_code'];
    _coin_rate = json['coin_rate'];
    _coin_icon = json['coin_icon'];
    _balance = json['balance'];
    _deposit = json['deposit'];
    _debt = json['debt'];
  }
}

