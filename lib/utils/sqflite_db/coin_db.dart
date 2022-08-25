import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ldp_gateway/model/Coin.dart';

class CoinDBProvider {
  static final CoinDBProvider dbase = CoinDBProvider();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    print("initDB");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "CoinDB.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          print("init");

          await db.execute(
              'CREATE TABLE coin (id INTEGER PRIMARY KEY autoincrement, '
                  'account TEXT not null,'
                  'pool TEXT not null,'
                  'coin_name TEXT not null,'
                  'coin_code TEXT not null,'
                  'coin_rate REAL not null,'
                  'coin_icon TEXT not null,'
                  'balance INTEGER not null,'
                  'deposit INTEGER not null,'
                  'debt INTEGER not null)'
            // "CREATE TABLE Transaction ("
            //     "id INTEGER primary key autoincrement,"
            //     "account TEXT not null,"
            //     "pool TEXT not null,"
            //     "coin_name TEXT not null,"
            //     "coin_code TEXT not null,"
            //     "coin_rate REAL not null,"
            //     "coin_icon TEXT not null,"
            //     "type TEXT not null,"
            //     "amount INTEGER not null,"
            //     "fee INTEGER not null,"
            //     "time TEXT not null)"
          );
        });
  }

  Future<List<Coin>> getAllCoins(String address) async {
    final db = await database;
    print("get all Coins");
    var res = await db.query("coin", where: "account = ?", whereArgs: [address], orderBy: "id ASC");
    List<Coin> list =
    res.isNotEmpty ? res.map((c) => Coin.fromJson(c)).toList() : [];
    return list;
  }

  Future<Coin?> getInfoCoin(int id) async {
    final db = await database;
    print("get Coin Infor");
    var res = await db.query("coin", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Coin.fromJson(res.first) : null;
  }

  deleteCoin(int id) async {
    final db = await database;
    return db.delete("coin", where: "id = ?", whereArgs: [id]);
  }

  updateCoin(Coin newCoin) async {
    final db = await database;
    print("update Coin Infor");
    var res = await db.update("coin", newCoin.toJson(),
        where: "id = ?", whereArgs: [newCoin.id]);
    return res;
  }

  newCoin(Coin newCoin) async {
    final db = await database;
    print("add db");
    var raw = await db.rawInsert(
        "INSERT into coin (account, pool, coin_name, coin_code, coin_rate, coin_icon, balance, deposit, debt)"
            ' VALUES (${newCoin.account},'
            '${newCoin.pool}'
            '${newCoin.coin_name}'
            '${newCoin.coin_code}'
            '${newCoin.coin_rate}'
            '${newCoin.coin_icon}'
            '${newCoin.balance}'
            '${newCoin.deposit}'
            '${newCoin.debt})');
    return raw;
  }

  insertCoin(Coin coin) async {
    final db = await database;
    print("add");
    coin.id = await db.insert("coin", coin.toJson());
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from coin");
  }
}
