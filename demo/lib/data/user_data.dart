/* 用户登录信息 */

import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  final String userIdKey = "user_id_key";
  final String userTokenKey = "user_token_key";
  final bool isLogin = false;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getUserId() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(userIdKey);
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(userTokenKey);
  }

  setUserId(String id) {
    _prefs.then((value) {
      value.setString(userIdKey, id);
    });
  }

  setUserToken(String token) {
    _prefs.then((value) {
      value.setString(userTokenKey, token);
    });
  }
}