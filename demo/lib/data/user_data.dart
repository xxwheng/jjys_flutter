/* 用户登录信息 */

import 'dart:convert';

import 'package:demo/model/user_info_bean.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier {
  final String userBeanKey = "user_bean_key";
  static bool isLogin = false;
  UserInfoBean user;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  factory UserData() => shared;

  static final UserData shared = UserData._internal();

  UserData._internal() {
    getUserBean().then((value) {
      if (value != null && value != this.user) {
        this.user = value;
        UserData.isLogin = true;
      }
    });
  }

  void loginSuccess(UserInfoBean user) {
    this.setUserBean(user);
    this.user = user;
    UserData.isLogin = true;
  }

  void logout() {
    this.removeUser();
    this.user = null;
    UserData.isLogin = false;
  }

  /* 获取用户缓存信息 */
  Future<UserInfoBean> getUserBean() async {
    SharedPreferences prefs = await _prefs;
    String mapString = prefs.getString(userBeanKey);
    if (mapString == null || mapString.isEmpty) {
      return null;
    } else {
      Map<String, dynamic> mapJson = jsonDecode(mapString);
      UserInfoBean cacheBean = UserInfoBean.fromJson(mapJson);
      return cacheBean;
    }
  }

  /* 缓存用户信息 */
  Future<bool> setUserBean(UserInfoBean user) async {
    Map<String, dynamic> mapJson = user.toJson();
    String jsonStr = jsonEncode(mapJson);
    SharedPreferences prefs = await _prefs;
    bool resValue = await prefs.setString(userBeanKey, jsonStr);
    return resValue;
  }

  /* 移除用户信息（未登录） */
  void removeUser() {
    _prefs.then((value) => value.remove(userBeanKey));
  }
}