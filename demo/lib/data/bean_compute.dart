import 'package:demo/model/config_yswork_bean.dart';
import 'package:demo/model/ys_comment_list.dart';
import 'package:demo/model/ys_detail_bean.dart';
import 'package:demo/model/ys_list_bean.dart';
import 'package:flutter/foundation.dart';

/* compute 解析 */

///* 月嫂列表 */
YsListBean parseYsList(dynamic json) {
  return YsListBean.fromJson(json);
}

Future<YsListBean> parseYsListCompute(json) async {
  return compute(parseYsList, json);
}

///* 月嫂筛选 配置 */
ConfigYsWorkBean parseYsConfig(dynamic value) {
  return ConfigYsWorkBean.fromJson(value);
}

Future<ConfigYsWorkBean> parseYsConfigCompute(json) {
  return compute(parseYsConfig, json);
}

///* 月嫂详情 */
YsDetailBean jsonParse(dynamic json) {
  return YsDetailBean.fromJson(json);
}
Future<YsDetailBean> parseYsDetailCompute(json) async {
  return compute(jsonParse, json);
}

///* 月嫂评论 */
YsCommentList parseYsCommentList(dynamic json) {
  return YsCommentList.fromJson(json);
}

Future<YsCommentList> parseYsCommentListCompute(json) async {
  return compute(parseYsCommentList, json);
}

///* 工作风采列表 */
List<String> parseWorkShowList(dynamic json) {
  return (json as List)
      ?.map(
          (e) => e == null || e['url'] == null ? null : e['url'].toString())
      ?.toList();
}
Future<List<String>> parseWorkShowListCompute(json) async {
  return compute(parseWorkShowList, json);
}