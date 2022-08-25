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

  Future<String?> get address async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final address = _sharePreferences.getString(Preferences.address);
    return address;
  }

  Future<bool> saveAddress (String address) async {
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.setString(Preferences.address, address);
    return res;
  }

  Future<bool> removeAddress() async{
    final SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    bool res = await _sharePreferences.remove(Preferences.address);
    return res;
  }
}

