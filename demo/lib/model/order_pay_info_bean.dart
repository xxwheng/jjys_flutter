import 'package:demo/data/order_data.dart';
import 'package:demo/model/order_index_bean.dart';

/// info_order : {"id":"2125","citycode":"103212","refer_id":"0","title":"住家月子服务(26天)","process":"0","status":"1","pay_type":"0","product_id":"47","product_days":"26","caregiver_id":"87","total_money":"18800.00","pay_money":"0.00","coupon_momey":"0.00","product_price":"18800.00","corp_id":"61"}
/// pay_limit : ""
/// charge_extra : {"total_money_sum":0,"total_money_topay":0,"data":[]}
/// info_caregiver : {"id":"87","citycode":"103212","name":"黄德梅","phone":"13842697470","level":"7","icon":"https://upload.jjys168.com/57555ac27e095.jpg","is_credit":1,"corp_id":"0","cityname":"深圳"}
/// info_product : {"id":"47","one_price":"646.15","two_price":"775.38","name":"住家月子服务","group_id":"13","market_price":"800.00"}

class OrderPayInfoBean {



  InfoOrder _infoOrder;
  String _payLimit;
  ChargeExtra _chargeExtra;
  InfoCaregiver _infoCaregiver;
  InfoProduct _infoProduct;

  InfoOrder get infoOrder => _infoOrder;
  String get payLimit => _payLimit;
  ChargeExtra get chargeExtra => _chargeExtra;
  InfoCaregiver get infoCaregiver => _infoCaregiver;
  InfoProduct get infoProduct => _infoProduct;

  OrderPayInfoBean({
    InfoOrder infoOrder,
      String payLimit,
    ChargeExtra chargeExtra,
    InfoCaregiver infoCaregiver,
    InfoProduct infoProduct}){
    _infoOrder = infoOrder;
    _payLimit = payLimit;
    _chargeExtra = chargeExtra;
    _infoCaregiver = infoCaregiver;
    _infoProduct = infoProduct;
}

  OrderPayInfoBean.fromJson(dynamic json) {
    _infoOrder = json["info_order"] != null ? InfoOrder.fromJson(json["info_order"]) : null;
    _payLimit = json["pay_limit"];
    _chargeExtra = json["charge_extra"] != null ? ChargeExtra.fromJson(json["charge_extra"]) : null;
    _infoCaregiver = json["info_caregiver"] != null ? InfoCaregiver.fromJson(json["info_caregiver"]) : null;
    _infoProduct = json["info_product"] != null ? InfoProduct.fromJson(json["info_product"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_infoOrder != null) {
      map["info_order"] = _infoOrder.toJson();
    }
    map["pay_limit"] = _payLimit;
    if (_chargeExtra != null) {
      map["charge_extra"] = _chargeExtra.toJson();
    }
    if (_infoCaregiver != null) {
      map["info_caregiver"] = _infoCaregiver.toJson();
    }
    if (_infoProduct != null) {
      map["info_product"] = _infoProduct.toJson();
    }
    return map;
  }

}