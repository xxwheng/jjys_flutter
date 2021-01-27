
import 'package:demo/model/xx_int_title.dart';
import 'package:demo/model/year_filter_bean.dart';
import 'package:demo/network/dio/http_error.dart';
import 'package:demo/network/manager/xx_network.dart';


/* 支付方式 */
enum JJPayType {
  aliPay,
  wxPay
}

JJPayType jjPayType(int value) {
  return JJPayType.values.firstWhere((element) => element.index == value);
}

/* 角色 类型*/
enum JJRoleType {
  unknown,
  matron,
  nurse,
  cuiRu,
  shortMatron,
  other
}

/* 值 转 枚举 */
JJRoleType jjRoleType(int value) {
  return JJRoleType.values.firstWhere((element) => element.index == value);
}

final List<String> _gCareTypeTitleArr = ["不限", "育婴护理师", "育儿护理师", "幼儿护理师"];
final List<String> _gYearTitleArr = ["不限", "30岁以下", "30~40岁", "40岁以上"];
final List<String> _gBabyNumArr = ["单胞胎", "双胞胎"];



/// 服务信息 单胞胎、双胞胎
final List<XXIntTitleBean> gBabyArray = _gBabyNumArr
    .asMap()
    .keys
    .map((e) => XXIntTitleBean(e + 1, _gBabyNumArr[e]))
    .toList();

/// 筛选 - 年龄列表 （YsFilterYearBean）
final List<YsFilterYearBean> gYearFilterArray = _gYearTitleArr
    .asMap()
    .keys
    .map((e) => YsFilterYearBean(e, _gYearTitleArr[e]))
    .toList();

/// 筛选 -  育婴师分类列表（YuyingFilterCareTypeBean）
final List<YuyingFilterCareTypeBean> gCareTypeFilterArray = _gCareTypeTitleArr
    .asMap()
    .keys
    .map((e) => YuyingFilterCareTypeBean(e, _gCareTypeTitleArr[e]))
    .toList();


/// 全局 网络请求
class GlobalNet {
  static Future orderCheckUnpay() {
    return XXNetwork.shared.post(params: {"methodName":"OrderCheckUnpay"}).then((value) {
      if (value['order_unpay'].toString() != "0") {
        throw HttpError(HttpError.OPERATOR_ERROR, "您有未完成的订单");
      }
    });
  }
}