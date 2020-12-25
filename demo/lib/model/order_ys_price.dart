/// order_price : {"group_id":"13","product_id":"47","name":"住家月子服务","service_days":"26","tag":"p2.2b","id":"47","one_price":"723.08","two_price":"867.69","level_id":"7","sum":"18800","price_days":"26","corp_id":"0","price_corp":"18800"}
/// corp_info : null
/// coupon : []

class OrderYsPrice {
  OrderPrice _orderPrice;
  dynamic _corpInfo;
  List<dynamic> _coupon;

  OrderPrice get orderPrice => _orderPrice;
  dynamic get corpInfo => _corpInfo;
  List<dynamic> get coupon => _coupon;

  OrderYsPrice({
    OrderPrice orderPrice,
      dynamic corpInfo, 
      List<dynamic> coupon}){
    _orderPrice = orderPrice;
    _corpInfo = corpInfo;
    _coupon = coupon;
}

  OrderYsPrice.fromJson(dynamic json) {
    _orderPrice = json["order_price"] != null ? OrderPrice.fromJson(json["order_price"]) : null;
    _corpInfo = json["corp_info"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_orderPrice != null) {
      map["order_price"] = _orderPrice.toJson();
    }
    map["corp_info"] = _corpInfo;
    if (_coupon != null) {
      map["coupon"] = _coupon.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// group_id : "13"
/// product_id : "47"
/// name : "住家月子服务"
/// service_days : "26"
/// tag : "p2.2b"
/// id : "47"
/// one_price : "723.08"
/// two_price : "867.69"
/// level_id : "7"
/// sum : "18800"
/// price_days : "26"
/// corp_id : "0"
/// price_corp : "18800"

class OrderPrice {
  String _groupId;
  String _productId;
  String _name;
  String _serviceDays;
  String _tag;
  String _id;
  String _onePrice;
  String _twoPrice;
  String _levelId;
  String _sum;
  String _priceDays;
  String _corpId;
  String _priceCorp;

  String get groupId => _groupId;
  String get productId => _productId;
  String get name => _name;
  String get serviceDays => _serviceDays;
  String get tag => _tag;
  String get id => _id;
  String get onePrice => _onePrice;
  String get twoPrice => _twoPrice;
  String get levelId => _levelId;
  String get sum => _sum;
  String get priceDays => _priceDays;
  String get corpId => _corpId;
  String get priceCorp => _priceCorp;

  OrderPrice({
      String groupId, 
      String productId, 
      String name, 
      String serviceDays, 
      String tag, 
      String id, 
      String onePrice, 
      String twoPrice, 
      String levelId, 
      String sum, 
      String priceDays, 
      String corpId, 
      String priceCorp}){
    _groupId = groupId;
    _productId = productId;
    _name = name;
    _serviceDays = serviceDays;
    _tag = tag;
    _id = id;
    _onePrice = onePrice;
    _twoPrice = twoPrice;
    _levelId = levelId;
    _sum = sum;
    _priceDays = priceDays;
    _corpId = corpId;
    _priceCorp = priceCorp;
}

  OrderPrice.fromJson(dynamic json) {
    _groupId = json["group_id"];
    _productId = json["product_id"];
    _name = json["name"];
    _serviceDays = json["service_days"];
    _tag = json["tag"];
    _id = json["id"];
    _onePrice = json["one_price"];
    _twoPrice = json["two_price"];
    _levelId = json["level_id"];
    _sum = json["sum"];
    _priceDays = json["price_days"];
    _corpId = json["corp_id"];
    _priceCorp = json["price_corp"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["group_id"] = _groupId;
    map["product_id"] = _productId;
    map["name"] = _name;
    map["service_days"] = _serviceDays;
    map["tag"] = _tag;
    map["id"] = _id;
    map["one_price"] = _onePrice;
    map["two_price"] = _twoPrice;
    map["level_id"] = _levelId;
    map["sum"] = _sum;
    map["price_days"] = _priceDays;
    map["corp_id"] = _corpId;
    map["price_corp"] = _priceCorp;
    return map;
  }

}