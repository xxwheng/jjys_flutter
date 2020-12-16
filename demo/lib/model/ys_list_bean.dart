
import 'package:demo/model/ys_item_bean.dart';
import 'package:json_annotation/json_annotation.dart';

/* 月嫂列表 */
class YsListBean extends Object {

  int page;

  int size;

  int total;

  int count;

  List<YsItemBean> data;

  YsListBean(this.page, this.size, this.total, this.count, this.data);

  factory YsListBean.fromJson(Map<String, dynamic> json) {
    return YsListBean(
      int.parse(json['page'].toString()) ?? 1,
      int.parse(json['size'].toString()) ?? 0,
      int.parse(json['total'].toString()) ?? 0,
      int.parse(json['count'].toString()) ?? 0,
      (json['data'] as List)
          ?.map((e) =>
      e == null ? null : YsItemBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }

}