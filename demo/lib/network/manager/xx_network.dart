

import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:demo/data/corp_data.dart';
import 'package:demo/model/corp_grop_bean.dart';
import 'package:demo/network/dio/http_config.dart';
import 'package:demo/network/dio/http_error.dart';
import 'package:demo/network/dio/http_util.dart';

/// 对网络层做一些处理 添加固定参数 打印请求、返回数据 特定异常处理
/// 单例shared
///
/// 返回Completer.future
class XXNetwork {

  factory XXNetwork() => shared;

  static final XXNetwork shared = XXNetwork._internal();

  CorpData _corpData;

  XXNetwork._internal() {
    _corpData = CorpData();
  }

  Future post({String path, Map<String, dynamic> params, String tag}) async {
    path ??= HttpConfig.path;
    params ??= Map<String, dynamic>();
    params["version"] = HttpConfig.version;
    params["platform"] = HttpConfig.getPlatform();
    CorpCityBean cacheBean = await _corpData.getCorpDataFromCache();
    params["citycode"] = cacheBean.cityCode;
    params["_corp_id"] = cacheBean.id;
    params["corp_id"] = cacheBean.id;
    // params["user_id"] = 190;
    // params["token"] = "b61384f49892846fa45219d28677e236";

    Completer completer = Completer();

    print("请求参数： ${params.toString()}");
    HttpUtil().post(path, params: params, resolve: (res) {
      print("返回数据： $res");
      if (res["code"] == 0) {
        completer.complete(res["data"]);
      } else {
        completer.completeError(HttpError(HttpError.DATA_ERROR, "操作失败"));
      }
    }, reject: (HttpError error) {
      completer.completeError(error);
    }, cancelTag: tag);

    return completer.future;
  }

}