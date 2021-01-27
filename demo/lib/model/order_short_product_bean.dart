/// products : [{"group_id":"12","product_id":"64","name":"短期月子服务","service_days":1,"tag":"p2.2a","id":"64","one_price":"400.00","two_price":"480.00","level_id":"2"},{"group_id":"12","product_id":"38","name":"短期月子服务","service_days":1,"tag":"p2.2a","id":"38","one_price":"400.00","two_price":"480.00","level_id":"3"},{"group_id":"12","product_id":"39","name":"短期月子服务","service_days":1,"tag":"p2.2a","id":"39","one_price":"500.00","two_price":"600.00","level_id":"4"},{"group_id":"12","product_id":"40","name":"短期月子服务","service_days":1,"tag":"p2.2a","id":"40","one_price":"600.00","two_price":"720.00","level_id":"5"},{"group_id":"12","product_id":"41","name":"短期月子服务","service_days":1,"tag":"p2.2a","id":"41","one_price":"700.00","two_price":"840.00","level_id":"6"},{"group_id":"12","product_id":"42","name":"短期月子服务","service_days":1,"tag":"p2.2a","id":"42","one_price":"800.00","two_price":"960.00","level_id":"7"},{"group_id":"12","product_id":"76","name":"短期月子服务","service_days":1,"tag":"p2.2a","id":"76","one_price":"900.00","two_price":"1080.00","level_id":"8"}]

/* 短期护理 产品列表 */
class OrderShortProductBean {
  List<Products> _products;

  List<Products> get products => _products;

  OrderShortProductBean({
      List<Products> products}){
    _products = products;
}

  OrderShortProductBean.fromJson(dynamic json) {
    if (json["products"] != null) {
      _products = [];
      json["products"].forEach((v) {
        _products.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_products != null) {
      map["products"] = _products.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// group_id : "12"
/// product_id : "64"
/// name : "短期月子服务"
/// service_days : 1
/// tag : "p2.2a"
/// id : "64"
/// one_price : "400.00"
/// two_price : "480.00"
/// level_id : "2"

class Products {
  String _groupId;
  String _productId;
  String _name;
  String _serviceDays;
  String _tag;
  String _id;
  String _onePrice;
  String _twoPrice;
  String _levelId;

  String get groupId => _groupId;
  String get productId => _productId;
  String get name => _name;
  String get serviceDays => _serviceDays;
  String get tag => _tag;
  String get id => _id;
  String get onePrice => _onePrice;
  String get twoPrice => _twoPrice;
  String get levelId => _levelId;

  Products({
      String groupId, 
      String productId, 
      String name,
      String serviceDays,
      String tag, 
      String id, 
      String onePrice, 
      String twoPrice, 
      String levelId}){
    _groupId = groupId;
    _productId = productId;
    _name = name;
    _serviceDays = serviceDays;
    _tag = tag;
    _id = id;
    _onePrice = onePrice;
    _twoPrice = twoPrice;
    _levelId = levelId;
}

  Products.fromJson(dynamic json) {
    _groupId = json["group_id"];
    _productId = json["product_id"];
    _name = json["name"];
    _serviceDays = json["service_days"].toString();
    _tag = json["tag"];
    _id = json["id"];
    _onePrice = json["one_price"];
    _twoPrice = json["two_price"];
    _levelId = json["level_id"];
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
    return map;
  }

}