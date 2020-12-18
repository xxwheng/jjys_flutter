/* 角色 类型*/
import 'package:demo/model/year_filter_bean.dart';

enum JJRoleType {
  unknown,
  matron,
  nurse,
}

/* 值 转 枚举 */
JJRoleType jjRoleType(int value) {
  return JJRoleType.values.firstWhere((element) => element.index == value);
}

final List<String> _gCareTypeTitleArr = ["不限", "育婴护理师", "育儿护理师", "幼儿护理师"];
final List<String> _gYearTitleArr = ["不限", "30岁以下", "30~40岁", "40岁以上"];

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
