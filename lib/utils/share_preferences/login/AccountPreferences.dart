import 'dart:async';
import 'dart:convert';
import 'package:ldp_gateway/utils/share_preferences/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPreferences {
  Future<String?> get username async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final username = _sharePreferences.getString(Preferences.username);
    return username;
  }

  Future<bool> saveUsername (String username) async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.setString(Preferences.username, username);
    return res;
  }

  Future<bool> removeUsername() async{
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.remove(Preferences.username);
    return res;
  }

  Future<String?> get password async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final password = _sharePreferences.getString(Preferences.password);
    return password;
  }

  Future<bool> savePassword (String password) async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.setString(Preferences.password, password);
    return res;
  }

  Future<bool> removePassword() async{
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.remove(Preferences.password);
    return res;
  }

  Future<bool> saveAccount(String account) async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    List<String> accounts = [];
    String? listAccount = _sharePreferences.getString(Preferences.account);
    if(listAccount == null) {
      accounts = [];
    } else {
      accounts = (jsonDecode(listAccount.toString())as List<dynamic>).cast<String>();
    }
    if(!accounts.contains(account)) accounts.add(account);
    bool res = await _sharePreferences.setString(Preferences.account, jsonEncode(accounts));
    return res;
  }

  Future<List<String>> getAllAccount() async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final listAccount = _sharePreferences.getString(Preferences.account);
    if (listAccount == null) return [];
    final List<String> accounts = (jsonDecode(listAccount.toString())as List<dynamic>).cast<String>();
    return accounts;
  }
}

