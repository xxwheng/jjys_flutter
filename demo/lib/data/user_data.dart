/* 用户登录信息 */

import 'dart:convert';

import 'package:demo/common/common.dart';
import 'package:demo/data/key_event_bus.dart';
import 'package:demo/model/user_info_bean.dart';
import 'package:demo/native/ios/mine_bridge.dart';
import 'package:demo/utils/bus/event_bus.dart';
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
        notifyListeners();
        eventBus.emit(EventBusKey.orderListRefresh);
      }
      logger.d("程序启动—同步登录态");
    });
  }

  /* 登录成功 存储信息 */
  void loginSuccess(UserInfoBean user) {
    this.setUserBean(user);
    this.user = user;
    UserData.isLogin = true;
    notifyListeners();
    MineNativeBridge.shared.nativeTokenCache(user);
  }

  /* 更新信息 */
  void changeUser({String nick, String headPhoto, int preDay}) {
    bool flag = false;
    logger.i("nick: $nick \n nickname: ${this.user.nickName}");
    if (null != nick && this.user.nickName != nick) {
      this.user.nickName = nick;
      flag = true;
    }
    if (null != headPhoto && this.user.headPhoto != headPhoto) {
      this.user.headPhoto = headPhoto;
      flag = true;
    }
    if (null != preDay && this.user.predictDay != preDay) {
      this.user.predictDay = preDay;
      flag = true;
    }
    logger.i(flag);
    if (flag) {
      this.setUserBean(this.user);
      logger.i("新的: ${this.user.nickName}");
      notifyListeners();
    }
  }

  /* 退出 移除信息 */
  void logout() {
    MineNativeBridge.shared.clearNativeCache();
    this.removeUser();
    this.user = null;
    UserData.isLogin = false;
    notifyListeners();
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