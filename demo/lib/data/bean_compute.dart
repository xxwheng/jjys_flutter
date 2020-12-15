import 'package:demo/model/ys_detail_bean.dart';
import 'package:flutter/foundation.dart';

/* compute 解析 */

///* 月嫂详情 */
YsDetailBean jsonParse(dynamic json) {
  return YsDetailBean.fromJson(json);
}
Future<YsDetailBean> ysDetailCompute(json) async {
  return compute(jsonParse, json);
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