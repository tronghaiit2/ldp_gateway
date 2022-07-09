import 'dart:async';
import 'package:ldp_gateway/utils/share_preferences/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<String?> get privatekey async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final privatekey = _sharePreferences.getString(Preferences.privatekey);
    return privatekey;
  }

  Future<bool> savePrivatekey (String privatekey) async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.setString(Preferences.privatekey, privatekey);
    return res;
  }

  Future<bool> removePrivatekey() async{
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.remove(Preferences.privatekey);
    return res;
  }

  Future<String?> get token async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final token = _sharePreferences.getString(Preferences.token);
    return token;
  }

  Future<bool> saveToken (String token) async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.setString(Preferences.token, token);
    return res;
  }

  Future<bool> removeToken() async{
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.remove(Preferences.token);
    return res;
  }

  Future<String?> get user async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final user = _sharePreferences.getString(Preferences.user);
    return user;
  }

  Future<bool> saveUser (String user) async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.setString(Preferences.user, user);
    return res;
  }

  Future<bool> removeUser() async{
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.remove(Preferences.user);
    return res;
  }
}

