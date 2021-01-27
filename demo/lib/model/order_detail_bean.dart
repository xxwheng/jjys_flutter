
/* 订单详情 */
import 'package:demo/data/global_data.dart';
import 'package:demo/data/order_data.dart';
import 'package:demo/model/order_index_bean.dart';

class OrderDetailBean extends OrderAbsBean {
  InfoProduct _infoProduct;
  List<CaregiverServer> _caregiverServer;
  InfoOrder _infoOrder;
  InfoCaregiver _infoCaregiver;
  ChargeExtra _chargeExtra;
  List<OrderPlan> _orderPlan;

  List<OrderControlBtModel> _ctrlBts;

  InfoProduct get infoProduct => _infoProduct;

  List<CaregiverServer> get caregiverServer => _caregiverServer;

  InfoOrder get infoOrder => _infoOrder;

  InfoCaregiver get infoCaregiver => _infoCaregiver;

  ChargeExtra get chargeExtra => _chargeExtra;

  List<OrderPlan> get orderPlay => _orderPlan;

  List<OrderControlBtModel> get ctrlBts => _ctrlBts;

  JJRoleType orderRole;

  /* 平台服务费 */
  OrderPlan yuServicePriceBean;
  /* 工资押金 */
  OrderPlan yuCashPledgeBean;
  /* 家政保险 */
  OrderPlan yuInsuranceBean;


  OrderDetailBean(
      {InfoProduct infoProduct,
        List<CaregiverServer> caregiverServer,
        InfoOrder infoOrder,
        InfoCaregiver infoCaregiver,
        ChargeExtra chargeExtra,
        List<OrderPlan> orderPlan,
        List<OrderControlBtModel> ctrlBts}) {
    _infoProduct = infoProduct;
    _caregiverServer = caregiverServer;
    _infoOrder = infoOrder;
    _infoCaregiver = infoCaregiver;
    _chargeExtra = chargeExtra;
    _orderPlan = orderPlan;
    _ctrlBts = ctrlBts;
  }

  OrderDetailBean.fromJson(dynamic json) {
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
    _orderPlan = (json['order_plan'] as List)?.map((e) => OrderPlan.fromJson(e))?.toList();

    _ctrlBts = OrderDataTool.getOrderCtrlBts(this);

    orderRole = OrderDataTool.getOrderType(_infoOrder.serviceItem, isEmpty: _caregiverServer.isEmpty);

    if (_orderPlan != null) {
      _orderPlan.forEach((e) {
        if (e.payItem == '1') {
          yuCashPledgeBean = e;
        } else if (e.payItem == '2') {
          yuServicePriceBean = e;
          var toPay = double.parse(e.moneyToPay ?? '0') ?? 0;
          var coupon = double.parse(_infoOrder.couponMomey ?? 0) ?? 0;
          yuServicePriceBean._moneyToPay = (toPay + coupon).toStringAsFixed(2);
        } else if (e.payItem == '3') {
          yuInsuranceBean = e;
        }
      });
    }

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

class OrderPlan {
  String _id;
  String _moneyPayed;
  String _moneyToPay;
  String _monthNumber;
  String _payItem;
  String _status;
  String get id => _id;
  String get moneyPayed => _moneyPayed;
  String get moneyToPay => _moneyToPay;
  String get monthNumber => _monthNumber;
  String get payItem => _payItem;
  String get status => _status;

  OrderPlan({
    String id,
    String moneyPayed,
    String moneyToPay,
    String monthNumber,
    String payItem,
    String status
  }) {
    _id = id;
    _moneyPayed = moneyPayed;
    _moneyToPay = moneyToPay;
    _monthNumber = monthNumber;
    _payItem = payItem;
    _status = status;
  }

  OrderPlan.fromJson(dynamic json) {
    _id = json['id'].toString();
    _moneyPayed = json['money_payed'].toString();
    _moneyToPay = json['money_topay'].toString();
    _monthNumber = json['month_number'].toString();
    _payItem = json['pay_item'].toString();
    var st = json['status'].toString();
    switch (st) {
      case '0': _status = "未付";break;
      case '1': _status = "部分已付"; break;
      default: _status = "已付"; break;
    }
  }
}