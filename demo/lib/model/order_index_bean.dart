import 'package:date_format/date_format.dart';

/// info_product :
///{"id":"47","citycode":"103212","name":"住家月子服务","one_price":"646.15","two_price":"775.38","market_price":"800.00","group_id":"13","level_id":"7","status":"1","desc":"26天起订，按单天价格计算。","service_days":"1","icon":"","default":"0","tag":"p2.2b"}
/// caregiver_server : [{"caregiver_id":"87","product_days":"26","service_start":"1608860272","service_end":"1611106672","remark":"app下单","service_day":26,"info_caregiver":{"id":"87","name":"黄德梅","phone":"13842697470","level":"7","icon":"https://upload.jjys168.com/57555ac27e095.jpg","is_credit":"1"}}]
/// info_order : {"id":"2120","citycode":"100168","num":"1","service_item":"1","order_no":"202012250937540001","product_id":"47","product_days":"26","caregiver_id":"87","pay_type":"0","process":"0","status":"1","total_money":"18800.00","pay_money":"0.00","product_price":"18800.00","coupon_id":"0","coupon_momey":"0.00","schedule_date":"1608860272","title":"住家月子服务(26天)","create_at":"1608860274","order_type":"0","contact":""}
/// info_caregiver : {"id":"87","citycode":"103212","name":"黄德梅","phone":"13842697470","level":"7","icon":"https://upload.jjys168.com/57555ac27e095.jpg","is_credit":1,"corp_id":"0","cityname":"深圳"}
/// charge_extra : {"total_money_sum":0,"total_money_topay":0,"data":[]}

/* 订单列表 单项 */
class OrderListBean {
  int page;

  int size;

  int total;

  int count;

  List<OrderIndexBean> data;

  OrderListBean(this.page, this.size, this.total, this.count, this.data);

  factory OrderListBean.fromJson(Map<String, dynamic> json) {
    return OrderListBean(
      int.parse(json['page'].toString()) ?? 1,
      int.parse(json['size'].toString()) ?? 0,
      int.parse(json['total'].toString()) ?? 0,
      int.parse(json['count'].toString()) ?? 0,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : OrderIndexBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }
}

class OrderIndexBean {
  InfoProduct _infoProduct;
  List<CaregiverServer> _caregiverServer;
  InfoOrder _infoOrder;
  InfoCaregiver _infoCaregiver;
  ChargeExtra _chargeExtra;

  InfoProduct get infoProduct => _infoProduct;

  List<CaregiverServer> get caregiverServer => _caregiverServer;

  InfoOrder get infoOrder => _infoOrder;

  InfoCaregiver get infoCaregiver => _infoCaregiver;

  ChargeExtra get chargeExtra => _chargeExtra;

  OrderIndexBean(
      {InfoProduct infoProduct,
      List<CaregiverServer> caregiverServer,
      InfoOrder infoOrder,
      InfoCaregiver infoCaregiver,
      ChargeExtra chargeExtra}) {
    _infoProduct = infoProduct;
    _caregiverServer = caregiverServer;
    _infoOrder = infoOrder;
    _infoCaregiver = infoCaregiver;
    _chargeExtra = chargeExtra;
  }

  OrderIndexBean.fromJson(dynamic json) {
    _infoProduct = json["info_product"] != null
        ? InfoProduct.fromJson(json["info_product"])
        : null;
    if (json["caregiver_server"] != null) {
      _caregiverServer = [];
      json["caregiver_server"].forEach((v) {
        _caregiverServer.add(CaregiverServer.fromJson(v));
      });
    }
    _infoOrder = json["info_order"] != null
        ? InfoOrder.fromJson(json["info_order"])
        : null;
    _infoCaregiver = json["info_caregiver"] != null
        ? InfoCaregiver.fromJson(json["info_caregiver"])
        : null;
    _chargeExtra = json["charge_extra"] != null
        ? ChargeExtra.fromJson(json["charge_extra"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_infoProduct != null) {
      map["info_product"] = _infoProduct.toJson();
    }
    if (_caregiverServer != null) {
      map["caregiver_server"] =
          _caregiverServer.map((v) => v.toJson()).toList();
    }
    if (_infoOrder != null) {
      map["info_order"] = _infoOrder.toJson();
    }
    if (_infoCaregiver != null) {
      map["info_caregiver"] = _infoCaregiver.toJson();
    }
    if (_chargeExtra != null) {
      map["charge_extra"] = _chargeExtra.toJson();
    }
    return map;
  }
}

/// total_money_sum : 0
/// total_money_topay : 0
/// data : []

class ChargeExtra {
  String _totalMoneySum;
  String _totalMoneyTopay;
  List<dynamic> _data;

  String get totalMoneySum => _totalMoneySum;

  String get totalMoneyTopay => _totalMoneyTopay;

  List<dynamic> get data => _data;

  ChargeExtra(
      {String totalMoneySum, String totalMoneyTopay, List<dynamic> data}) {
    _totalMoneySum = totalMoneySum;
    _totalMoneyTopay = totalMoneyTopay;
    _data = data;
  }

  ChargeExtra.fromJson(dynamic json) {
    _totalMoneySum = json["total_money_sum"].toString();
    _totalMoneyTopay = json["total_money_topay"].toString();
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["total_money_sum"] = _totalMoneySum;
    map["total_money_topay"] = _totalMoneyTopay;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "87"
/// citycode : "103212"
/// name : "黄德梅"
/// phone : "13842697470"
/// level : "7"
/// icon : "https://upload.jjys168.com/57555ac27e095.jpg"
/// is_credit : 1
/// corp_id : "0"
/// cityname : "深圳"

class InfoCaregiver {
  String _id;
  String _citycode;
  String _name;
  String _phone;
  String _level;
  String _careType;
  String _icon;
  String _isCredit;
  String _corpId;
  String _cityname;

  String get id => _id;

  String get citycode => _citycode;

  String get name => _name;

  String get phone => _phone;

  String get level => _level;

  String get careType => _careType;

  String get icon => _icon;

  String get isCredit => _isCredit;

  String get corpId => _corpId;

  String get cityname => _cityname;

  InfoCaregiver(
      {String id,
      String citycode,
      String name,
      String phone,
      String level,
      String careType,
      String icon,
      String isCredit,
      String corpId,
      String cityname}) {
    _id = id;
    _citycode = citycode;
    _name = name;
    _phone = phone;
    _level = level;
    _careType = careType;
    _icon = icon;
    _isCredit = isCredit;
    _corpId = corpId;
    _cityname = cityname;
  }

  InfoCaregiver.fromJson(dynamic json) {
    _id = json["id"].toString();
    _citycode = json["citycode"].toString();
    _name = json["name"];
    _phone = json["phone"];
    _level = json["level"].toString();
    _careType = json["care_type"].toString();
    _icon = json["icon"];
    _isCredit = json["is_credit"].toString();
    _corpId = json["corp_id"].toString();
    _cityname = json["cityname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["citycode"] = _citycode;
    map["name"] = _name;
    map["phone"] = _phone;
    map["level"] = _level;
    map["care_type"] = _careType;
    map["icon"] = _icon;
    map["is_credit"] = _isCredit;
    map["corp_id"] = _corpId;
    map["cityname"] = _cityname;
    return map;
  }
}

/// id : "2120"
/// citycode : "100168"
/// num : "1"
/// service_item : "1"
/// order_no : "202012250937540001"
/// product_id : "47"
/// product_days : "26"
/// caregiver_id : "87"
/// pay_type : "0"
/// process : "0"
/// status : "1"
/// total_money : "18800.00"
/// pay_money : "0.00"
/// product_price : "18800.00"
/// coupon_id : "0"
/// coupon_momey : "0.00"
/// schedule_date : "1608860272"
/// title : "住家月子服务(26天)"
/// create_at : "1608860274"
/// order_type : "0"
/// contact : ""

class InfoOrder {
  String _id;
  String _citycode;
  String _num;
  String _serviceItem;
  String _orderNo;
  String _productId;
  String _productDays;
  String _caregiverId;
  String _payType;
  String _process;
  String _status;
  String _totalMoney;
  String _payMoney;
  String _productPrice;
  String _couponId;
  String _couponMomey;
  String _scheduleDate;
  String _title;
  String _createAt;
  String _orderType;
  String _contact;
  String _attribute;

  String get id => _id;

  String get citycode => _citycode;

  String get num => _num;

  //  service_item：1月嫂订单；2催乳订单；3育婴师单；99更多服务【催乳,摄影等】
  String get serviceItem => _serviceItem;

  String get orderNo => _orderNo;

  String get productId => _productId;

  String get productDays => _productDays;

  String get caregiverId => _caregiverId;

  String get payType => _payType;

  String get process => _process;

  String get status => _status;

  String get totalMoney => _totalMoney;

  String get payMoney => _payMoney;

  String get productPrice => _productPrice;

  String get couponId => _couponId;

  String get couponMomey => _couponMomey;

  String get scheduleDate => _scheduleDate;

  String get title => _title;

  String get createAt => _createAt;

  String get orderType => _orderType;

  String get contact => _contact;

  String get attribute => _attribute;

  InfoOrder(
      {String id,
      String citycode,
      String num,
      String serviceItem,
      String orderNo,
      String productId,
      String productDays,
      String caregiverId,
      String payType,
      String process,
      String status,
      String totalMoney,
      String payMoney,
      String productPrice,
      String couponId,
      String couponMomey,
      String scheduleDate,
      String title,
      String createAt,
      String orderType,
      String contact,
      String attribute}) {
    _id = id;
    _citycode = citycode;
    _num = num;
    _serviceItem = serviceItem;
    _orderNo = orderNo;
    _productId = productId;
    _productDays = productDays;
    _caregiverId = caregiverId;
    _payType = payType;
    _process = process;
    _status = status;
    _totalMoney = totalMoney;
    _payMoney = payMoney;
    _productPrice = productPrice;
    _couponId = couponId;
    _couponMomey = couponMomey;
    _scheduleDate = scheduleDate;
    _title = title;
    _createAt = createAt;
    _orderType = orderType;
    _contact = contact;
    _attribute = attribute;
  }

  InfoOrder.fromJson(dynamic json) {
    _id = json["id"].toString();
    _citycode = json["citycode"];
    _num = json["num"].toString();
    _serviceItem = json["service_item"].toString();
    _orderNo = json["order_no"];
    _productId = json["product_id"].toString();
    _productDays = json["product_days"].toString();
    _caregiverId = json["caregiver_id"].toString();
    _payType = json["pay_type"].toString();
    _process = json["process"].toString();
    _status = json["status"].toString();
    _totalMoney = json["total_money"].toString();
    _payMoney = json["pay_money"].toString();
    _productPrice = json["product_price"].toString();
    _couponId = json["coupon_id"].toString();
    _couponMomey = json["coupon_momey"].toString();
    var timestamp = int.parse(json["schedule_date"].toString()) ?? 0;
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    _scheduleDate = formatDate(date, [yyyy, '-', mm, '-', dd]);
    _title = json["title"];
    _createAt = json["create_at"];
    _orderType = json["order_type"].toString();
    _contact = json["contact"];
    _attribute = json["attribute"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["citycode"] = _citycode;
    map["num"] = _num;
    map["service_item"] = _serviceItem;
    map["order_no"] = _orderNo;
    map["product_id"] = _productId;
    map["product_days"] = _productDays;
    map["caregiver_id"] = _caregiverId;
    map["pay_type"] = _payType;
    map["process"] = _process;
    map["status"] = _status;
    map["total_money"] = _totalMoney;
    map["pay_money"] = _payMoney;
    map["product_price"] = _productPrice;
    map["coupon_id"] = _couponId;
    map["coupon_momey"] = _couponMomey;
    map["schedule_date"] = _scheduleDate;
    map["title"] = _title;
    map["create_at"] = _createAt;
    map["order_type"] = _orderType;
    map["contact"] = _contact;
    return map;
  }
}

/// caregiver_id : "87"
/// product_days : "26"
/// service_start : "1608860272"
/// service_end : "1611106672"
/// remark : "app下单"
/// service_day : 26
/// info_caregiver : {"id":"87","name":"黄德梅","phone":"13842697470","level":"7","icon":"https://upload.jjys168.com/57555ac27e095.jpg","is_credit":"1"}

class CaregiverServer {
  String _caregiverId;
  String _productDays;
  String _serviceStart;
  String _serviceEnd;
  String _remark;
  String _serviceDay;
  InfoCaregiver _infoCaregiver;

  String get caregiverId => _caregiverId;

  String get productDays => _productDays;

  String get serviceStart => _serviceStart;

  String get serviceEnd => _serviceEnd;

  String get remark => _remark;

  String get serviceDay => _serviceDay;

  InfoCaregiver get infoCaregiver => _infoCaregiver;

  CaregiverServer(
      {String caregiverId,
      String productDays,
      String serviceStart,
      String serviceEnd,
      String remark,
      String serviceDay,
      InfoCaregiver infoCaregiver}) {
    _caregiverId = caregiverId;
    _productDays = productDays;
    _serviceStart = serviceStart;
    _serviceEnd = serviceEnd;
    _remark = remark;
    _serviceDay = serviceDay;
    _infoCaregiver = infoCaregiver;
  }

  CaregiverServer.fromJson(dynamic json) {
    _caregiverId = json["caregiver_id"].toString();
    _productDays = json["product_days"].toString();
    _serviceStart = json["service_start"];
    _serviceEnd = json["service_end"];
    _remark = json["remark"];
    _serviceDay = json["service_day"].toString();
    _infoCaregiver = json["info_caregiver"] != null
        ? InfoCaregiver.fromJson(json["info_caregiver"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["caregiver_id"] = _caregiverId;
    map["product_days"] = _productDays;
    map["service_start"] = _serviceStart;
    map["service_end"] = _serviceEnd;
    map["remark"] = _remark;
    map["service_day"] = _serviceDay;
    if (_infoCaregiver != null) {
      map["info_caregiver"] = _infoCaregiver.toJson();
    }
    return map;
  }
}

/// id : "47"
/// citycode : "103212"
/// name : "住家月子服务"
/// one_price : "646.15"
/// two_price : "775.38"
/// market_price : "800.00"
/// group_id : "13"
/// level_id : "7"
/// status : "1"
/// desc : "26天起订，按单天价格计算。"
/// service_days : "1"
/// icon : ""
/// default : "0"
/// tag : "p2.2b"

class InfoProduct {
  String _id;
  String _citycode;
  String _name;
  String _onePrice;
  String _twoPrice;
  String _marketPrice;
  String _groupId;
  String _levelId;
  String _status;
  String _desc;
  String _serviceDays;
  String _icon;
  String _default;
  String _tag;

  String get id => _id;

  String get citycode => _citycode;

  String get name => _name;

  String get onePrice => _onePrice;

  String get twoPrice => _twoPrice;

  String get marketPrice => _marketPrice;

  String get groupId => _groupId;

  String get levelId => _levelId;

  String get status => _status;

  String get desc => _desc;

  String get serviceDays => _serviceDays;

  String get icon => _icon;

  String get isDefault => _default;

  String get tag => _tag;

  InfoProduct(
      {String id,
      String citycode,
      String name,
      String onePrice,
      String twoPrice,
      String marketPrice,
      String groupId,
      String levelId,
      String status,
      String desc,
      String serviceDays,
      String icon,
      String isDefault,
      String tag}) {
    _id = id;
    _citycode = citycode;
    _name = name;
    _onePrice = onePrice;
    _twoPrice = twoPrice;
    _marketPrice = marketPrice;
    _groupId = groupId;
    _levelId = levelId;
    _status = status;
    _desc = desc;
    _serviceDays = serviceDays;
    _icon = icon;
    _default = isDefault;
    _tag = tag;
  }

  InfoProduct.fromJson(dynamic json) {
    _id = json["id"].toString();
    _citycode = json["citycode"];
    _name = json["name"];
    _onePrice = json["one_price"].toString();
    _twoPrice = json["two_price"].toString();
    _marketPrice = json["market_price"].toString();
    _groupId = json["group_id"].toString();
    _levelId = json["level_id"].toString();
    _status = json["status"].toString();
    _desc = json["desc"];
    _serviceDays = json["service_days"].toString();
    _icon = json["icon"];
    _default = json["default"];
    _tag = json["tag"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["citycode"] = _citycode;
    map["name"] = _name;
    map["one_price"] = _onePrice;
    map["two_price"] = _twoPrice;
    map["market_price"] = _marketPrice;
    map["group_id"] = _groupId;
    map["level_id"] = _levelId;
    map["status"] = _status;
    map["desc"] = _desc;
    map["service_days"] = _serviceDays;
    map["icon"] = _icon;
    map["default"] = _default;
    map["tag"] = _tag;
    return map;
  }
}
