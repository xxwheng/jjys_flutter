
import 'package:demo/common/common.dart';
import 'package:demo/model/user_info_bean.dart';
import 'package:flutter/services.dart';

class MineNativeBridge {

  factory MineNativeBridge() => shared;

  static final MineNativeBridge shared = MineNativeBridge._internal();

  MineNativeBridge._internal();

  static const platform = const MethodChannel("com.jjys.ios");

  /// 传登录态
  Future<bool> nativeTokenCache(UserInfoBean bean) async {
    var res = false;
    final Map<String, String> param = {
      "token": bean.token,
      "id": bean.id
    };
    try {
      res = await platform.invokeMethod("cache_token", param);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return res;
  }

  /// 清空登录态
  Future<bool> clearNativeCache() async {
    var res = false;
    try {
      res = await platform.invokeMethod("cache_clear");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return res;
  }

  /// 跳转宝妈心声
  Future<bool> gotoCommentWeb() async {
    var res = false;
    try {
      res = await platform.invokeMethod("goto_comment_web");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return res;
  }

  /// 跳转优惠券
  Future<bool> gotoMyCoupon() async {
    var res = false;
    try {
      res = await platform.invokeMethod("goto_myCoupon");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return res;
  }

  /// 跳转去关于
  Future<bool> gotoAbout() async {
    var res = false;
    try {
      res = await platform.invokeMethod("goto_about");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return res;
  }

  /// 跳转文章
  Future<bool> gotoArticleWeb(String id, String title) async {
    var res = false;
    final Map<String, String> params = {
      "id": id,
      "title": title
    };
    try {
      res = await platform.invokeMethod("goto_article_web", params);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return res;
  }

}