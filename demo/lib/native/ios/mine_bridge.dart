
import 'package:demo/common/common.dart';
import 'package:flutter/services.dart';

class MineNativeBridge {
  static const platform = const MethodChannel("com.jjys.ios");


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

  Future<bool> notificationToken() async {
    var res = false;
    try {
      res = await platform.invokeMethod("setToken");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return res;
  }
}