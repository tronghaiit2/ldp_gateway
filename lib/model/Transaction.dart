class aTransaction {
  int? _id;
  late String _account;
  late String _pool;
  late String _coin_name;
  late String _coin_code;
  late double _coin_rate;
  late String _coin_icon;
  late int _coin_id;
  late String _type;
  late int _amount;
  late int _fee;
  late String _time;

  aTransaction({
    int? id,
    required String account,
    required String pool,
    required String coin_name,
    required String coin_code,
    required double coin_rate,
    required String coin_icon,
    required int coin_id,
    required String type,
    required int amount,
    required int fee,
    required String time,
  }) {
    this._id = id;
    this._account = account;
    this._pool = pool;
    this._coin_name = coin_name;
    this._coin_code = coin_code;
    this._coin_rate = coin_rate;
    this._coin_icon = coin_icon;
    this._coin_id = coin_id;
    this._type = type;
    this._amount = amount;
    this._fee = fee;
    this._time = time;
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
  int get coin_id => this._coin_id;
  set coin_id(int coin_id) => this._coin_id = coin_id;
  String get type => this._type;
  set type(String type) => this._type = type;
  int get amount => this._amount;
  set amount(int amount) => this._amount = amount;
  int get fee => this._fee;
  set fee(int fee) => this._fee = fee;
  String get time => this._time;
  set time(String time) => this._time = time;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account'] = this.account;
    data['pool'] = this.pool;
    data['coin_name'] = this.coin_name;
    data['coin_code'] = this.coin_code;
    data['coin_rate'] = this.coin_rate;
    data['coin_icon'] = this.coin_icon;
    data['coin_id'] = this.coin_id;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['fee'] = this.fee;
    data['time'] = this.time;
    return data;
  }

  aTransaction.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _account = json['account'];
    _pool = json['pool'];
    _coin_name = json['coin_name'];
    _coin_code = json['coin_code'];
    _coin_rate = json['coin_rate'];
    _coin_icon = json['coin_icon'];
    _coin_id = json['coin_id'];
    _type = json['type'];
    _amount = json['amount'];
    _fee = json['fee'];
    _time = json['time'];
  }
}

