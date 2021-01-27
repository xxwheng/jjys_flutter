/// water_list : [{"create_at":"1609223787","title":"预约下单","detail":"2020年12月29日 14时36分 预约下单!","step":"0"},{"create_at":"1609231203","title":"取消订单","detail":"2020年12月29日 16时40分 取消订单!","step":"9"}]

class OrderWaterBean {
  List<WaterList> _waterList;

  List<WaterList> get waterList => _waterList;

  OrderWaterBean({
      List<WaterList> waterList}){
    _waterList = waterList;
}

  OrderWaterBean.fromJson(dynamic json) {
    if (json["water_list"] != null) {
      _waterList = [];
      json["water_list"].forEach((v) {
        _waterList.add(WaterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_waterList != null) {
      map["water_list"] = _waterList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// create_at : "1609223787"
/// title : "预约下单"
/// detail : "2020年12月29日 14时36分 预约下单!"
/// step : "0"

class WaterList {
  String _createAt;
  String _title;
  String _detail;
  String _step;

  String get createAt => _createAt;
  String get title => _title;
  String get detail => _detail;
  String get step => _step;

  WaterList({
      String createAt, 
      String title, 
      String detail, 
      String step}){
    _createAt = createAt;
    _title = title;
    _detail = detail;
    _step = step;
}

  WaterList.fromJson(dynamic json) {
    _createAt = json["create_at"];
    _title = json["title"];
    _detail = json["detail"];
    _step = json["step"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["create_at"] = _createAt;
    map["title"] = _title;
    map["detail"] = _detail;
    map["step"] = _step;
    return map;
  }

}