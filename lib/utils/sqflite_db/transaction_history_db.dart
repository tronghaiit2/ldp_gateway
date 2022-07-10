import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ldp_gateway/model/Transaction.dart';

class DBProvider {
  static final DBProvider dbase = DBProvider();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    print("initDB");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TransactionDB.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          print("init");

          await db.execute(
              'CREATE TABLE aTransaction (id INTEGER PRIMARY KEY autoincrement, '
                  'account TEXT not null,'
                  'pool TEXT not null,'
                  'coin_name TEXT not null,'
                  'coin_code TEXT not null,'
                  'coin_rate REAL not null,'
                  'coin_icon TEXT not null,'
                  'type TEXT not null,'
                  'amount INTEGER not null,'
                  'fee INTEGER not null,'
                  'time TEXT not null)'
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

  Future<List<aTransaction>> getAllTransactions(String address) async {
    print("get all Transactions");
    final db = await database;
    var res = await db.query("aTransaction", where: "account = ?", whereArgs: [address], orderBy: "id DESC");
    List<aTransaction> list =
    res.isNotEmpty ? res.map((c) => aTransaction.fromJson(c)).toList() : [];
    return list;
  }

  Future<aTransaction?> getInfoTransaction(int id) async {
    final db = await database;
    var res = await db.query("aTransaction", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? aTransaction.fromJson(res.first) : null;
  }

  deleteTransaction(int id) async {
    final db = await database;
    return db.delete("aTransaction", where: "id = ?", whereArgs: [id]);
  }

  updateTransaction(aTransaction newTransaction) async {
    final db = await database;
    var res = await db.update("aTransaction", newTransaction.toJson(),
        where: "id = ?", whereArgs: [newTransaction.id]);
    return res;
  }

  newTransaction(aTransaction newTransaction) async {
    final db = await database;
    print("add db");
    var raw = await db.rawInsert(
        "INSERT into aTransaction (account, pool, coin_name, coin_code, coin_rate, coin_icon, type, amount, fee, time)"
            ' VALUES (${newTransaction.account},'
            '${newTransaction.pool}'
            '${newTransaction.coin_name}'
            '${newTransaction.coin_code}'
            '${newTransaction.coin_rate}'
            '${newTransaction.coin_icon}'
            '${newTransaction.type}'
            '${newTransaction.amount}'
            '${newTransaction.fee}'
            '${newTransaction.time})');
    return raw;
  }

  insertTransaction(aTransaction transaction) async {
    final db = await database;
    print("add");
    transaction.id = await db.insert("aTransaction", transaction.toJson());
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from aTransaction");
  }

  bool checkExpired(date1, date2) {
    print("date1: " + date1.toString());
    print("date2: " + date2.toString());
    print(date1.difference(date2).inDays.toString());
    return date1.difference(date2).inDays > 7 ? true : false;
  }

  autoDelete() async {
    final now = DateTime.now();
    print("Auto delete Transactions");
    final db = await database;
    var res = await db.query("aTransaction");
    List<aTransaction> listTrans =
    res.isNotEmpty ? res.map((c) => aTransaction.fromJson(c)).toList() : [];
    for (var trans in listTrans) {
      if (checkExpired(now, DateTime.parse(trans.time)) == true) {
        await deleteTransaction(trans.id!);
        print("Delete 1 Transaction");
      }
    }
  }
}
