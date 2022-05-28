import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperSharedPreferences {
  static const String userId = 'userId';
  static const String token = 'token';
  static const String isLogin = 'isLogin';
  static const String isAdmin = 'isAdmin';

  static late final String? savedToken;
  static late final String? savedUserId;

  ////////////////////---SET---////////////////////
  static Future<bool> saveUserId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    debugPrint('save userId');
    savedUserId = id;
    return await preferences.setString(userId, id);
  }

  static Future<bool> saveToken(String userToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    savedToken = userToken;
    return await preferences.setString(token, userToken);
  }

  static Future<bool> saveUserLogin(bool userIsLogin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.setBool(isLogin, userIsLogin);
  }

  static Future<bool> saveAdmin(bool isUserAdmin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.setBool(isAdmin, isUserAdmin);
  }

  ////////////////////---GET---////////////////////
  static Future<bool?> getUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isLogin);
  }

  static Future<bool?> getAdmin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isAdmin);
  }

  static Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(userId);
  }

  static Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(token);
  }

  static Future clearAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(userId);
    await preferences.remove(token);
    await preferences.remove(isLogin);
    await preferences.remove(isAdmin);
  }
}
