import 'dart:async';
import 'package:demo/data/corp_data.dart';
import 'package:demo/data/user_data.dart';
import 'package:demo/network/dio/http_config.dart';
import 'package:demo/network/dio/http_error.dart';
import 'package:demo/network/dio/http_util.dart';
import 'package:demo/utils/v_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

/// 对网络层做一些处理 添加固定参数 打印请求、返回数据 特定异常处理
/// 单例shared
///
/// 返回Completer.future
class XXNetwork {

  factory XXNetwork() => shared;

  static final XXNetwork shared = XXNetwork._internal();

  CorpData _corpData;
  UserData _userData;

  XXNetwork._internal() {
    _corpData = CorpData();
    _userData = UserData();
  }

  Future post({String path, Map<String, dynamic> params, String tag}) async {

    path ??= HttpConfig.path;
    params ??= Map<String, dynamic>();
    params["version"] = HttpConfig.version;
    params["platform"] = HttpConfig.getPlatform();
    /* 加盟商信息 */
    params["citycode"] = _corpData.corpBean.cityCode;
    params["_corp_id"] = _corpData.corpBean.id;
    params["corp_id"] = _corpData.corpBean.id;
    /* 登录态 */
    if (_userData.user != null && _userData.user.token.isNotEmpty) {
      params["user_id"] = _userData.user.id;
      params["token"] = _userData.user.token;
    }

    params["user_id"] = "190";
    params["token"] = "1ca9af4fdf81fc6ab6c302027caeb7ce";

    Completer completer = Completer();

    print("请求参数： ${params.toString()}");
    HttpUtil().post(path, params: params, resolve: (res) {
      print("返回数据： $res");
      if (res["code"] == 0) {
        completer.complete(res["data"]);
      } else if (res["code"] == 10003) {
        /// data: {scalar: user_id}
      } else {
        VToast.show(res["msg"].toString());
//        completer.completeError(HttpError(HttpError.DATA_ERROR, "操作失败"));
      }
    }, reject: (HttpError error) {
      completer.completeError(error);
    }, cancelTag: tag);

    return completer.future;
  }

  /* 上传图片 */
  Future upload({String path, String filePath, Map<String, dynamic> params, String tag}) async {
    path ??= HttpConfig.path;
    params ??= Map<String, dynamic>();
    params["methodName"] = "FileUpload";
    params["version"] = HttpConfig.version;
    params["platform"] = HttpConfig.getPlatform();
    /* 加盟商信息 */
    params["citycode"] = _corpData.corpBean.cityCode;
    params["_corp_id"] = _corpData.corpBean.id;
    params["corp_id"] = _corpData.corpBean.id;
    /* 登录态 */
    if (_userData.user != null && _userData.user.token.isNotEmpty) {
      params["user_id"] = _userData.user.id;
      params["token"] = _userData.user.token;
    }

    var compressFile = await FlutterNativeImage.compressImage(filePath, quality: 33);

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(compressFile.path)
    });

    Completer completer = Completer();
    print("请求参数： ${params.toString()}");
    HttpUtil().post(path, data: data, params: params, resolve: (res) {
      print("返回数据： $res");
      if (res["code"] == 0) {
        completer.complete(res["data"]);
      } else if (res["code"] == 10003) {
        /// data: {scalar: user_id}
      } else {
        completer.completeError(HttpError(HttpError.DATA_ERROR, "上传失败"));
      }
    }, reject: (HttpError error) {
      completer.completeError(error);
    }, cancelTag: tag);

    return completer.future;

  }

}