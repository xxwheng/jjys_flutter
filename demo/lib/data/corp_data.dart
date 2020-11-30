

/*  需要缓存的 corpData、corpInfo */

/* AppStart
* 1.缓存获取corpData
*   无值=> 使用默认corpData
*
* 2.首页定位，提示最近corpData
*     切换=> corpInfo 缓存并provider全局切换
*
* 3.分组切换CorpData
*     切换=> corpInfo 缓存并provider全局切换
*  */

import 'dart:async';

import 'package:demo/model/corp_grop_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CorpData {

  static final String corpCityKey = "corp_city_key";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /* 存储当前加盟商corp信息 */
  Future<bool> setCorpDataCache(CorpCityBean bean) async {
    Map<String, dynamic> mapJson = bean.toJson();
    String jsonStr = jsonEncode(mapJson);
    SharedPreferences prefs = await _prefs;
    bool resValue = await prefs.setString(corpCityKey, jsonStr);
    return resValue;
  }

  /* 缓存提取加盟商corp信息 */
  Future<CorpCityBean> getCorpDataFromCache() async {
    SharedPreferences prefs = await _prefs;
    String mapString = prefs.getString(corpCityKey);
    if (mapString == null || mapString.isEmpty) {
      CorpCityBean _default = this._defaultCorpBean();
      return _default;
    } else {
      Map<String, dynamic> mapJson = jsonDecode(mapString);
      CorpCityBean cacheBean = CorpCityBean.fromJson(mapJson);
      return cacheBean;
    }
  }

  CorpCityBean _defaultCorpBean() {
    return CorpCityBean(
        "1",
        "深圳",
        "深圳",
        "深圳",
        "103212",
        "0");
  }
}