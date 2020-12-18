
import 'package:demo/model/corp_grop_bean.dart';

class CityBean {
  String id;
  String cityCode;
  String belongCode;
  String cityName;
  List<CityBean> children;

  CityBean(this.id, this.cityCode, this.belongCode, this.cityName, this.children);

  factory CityBean.fromJson(dynamic json) {
    return CityBean(
        json['id'].toString(),
        json['city_code'].toString(),
        json['belong_code'].toString(),
        json['city_name'].toString(),
        (json['children'] as List)?.map((e) => e==null?null:CityBean.fromJson(e))?.toList());
  }
}