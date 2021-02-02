import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/model/order_index_bean.dart';
import 'package:demo/model/order_pay_info_bean.dart';
import 'package:flutter/material.dart';

/// 订单状态 进度
///
/// status 1未付款，2预付款，3已付款，4已退款
/// process
/// 0未付款，1已付订金，2等待服务，3服务中，
/// 4服务结束，5待评论，6待结算，7已完成，
/// 8已取消，9退款中，10已退款
/// ------ 6 7微信端均展示已完成
///
/// process==0,倒计时显示
/// 支付了的就不能取消订单 status > 1 || process > 0
///
///
/// service_item 1月嫂订单；2催乳订单；3育婴师单；99更多服务【催乳,摄影等】
///
///
/// //// ------------ 按钮 🙅‍♀ 按钮 文字
///
/// process == 0                        // 取消订单 b2b2b2
/// process == 3 && service_item == 1   // 续单
/// process >= 3 && process <= 7        // 评价服务 （有服务技师的时候）1
/// status == 1 && process != 8         // 立即付款 1
/// status==2                           // 支付尾款 1
/// status == 3 && service_item == 3    // 支付工资
/// status == 3 && charge_extra!=null && charge_extra.total_money_topay>0  // 支付节日费用


///  评价 和 支付  另分功能
///  (status == 2 || status == 3) && service_item == 3  /// 育婴评价
///  else 一般评价
///
/// (status == 1 || status == 2) && service_item == 3
///                   commissionpaystatus == 1 育婴确认支付
///                   commissionpaystatus == 0 育婴工资支付
///  else 一般确认支付

/// 月嫂支付方式
enum OrderPayType {
  /* 一般支付  支付定金或者全款  有的选 (俩圆圈按钮) */
  payNormal,
  /* 支付尾款  [没得选 就一个] */
  tailPay,
  /* 支付全款  [短单什么的] */
  allPay,
  /* 支付限额什么的 */
  limitPay,
}

OrderPayType ysOrderPayType(int value) {
  return OrderPayType.values.firstWhere((element) => element.index == value);
}

/// 订单功能按钮
enum OrderBtsType {
  /* 续单 */
  reOrder,
  /* 取消订单 */
  cancel,
  /* 育婴评价 */
  evaluateNurse,
  /* 一般评价 */
  evaluateNormal,
  /* 育婴师订单支付 */
  payNurseOrder,
  /* 育婴师工资支付 */
  payNurseSalary,
  /* 节假日额外支付 */
  payExtra,
  /* 一般支付  支付定金或者全款  有的选 (俩圆圈按钮) */
  payNormal,
  /* 支付尾款  [没得选 就一个] */
  tailPay,
  /* 支付全款  [短单什么的] */
  allPay,
  /* 支付限额什么的 */
  limitPay,
}


class OrderControlBtModel {
  OrderBtsType type;
  String title;
  Color border;
  Color color;

  OrderControlBtModel(this.type, this.title, this.color, this.border);
}

class OrderDataTool {

  /* 计算订单支付金额 */
  static void caculateOrderPayPrice(InfoOrder bean) {
    /* 总的支付金额 = 总金额 - 已支付金额 - 优惠券金额 */
    var totalMoney = double.parse(bean.totalMoney) ?? 0;
    var alPayMoney = double.parse(bean.payMoney) ?? 0;
    var toPayMoney = totalMoney - alPayMoney;
    var preToPay = (toPayMoney * 0.2).toStringAsFixed(2);
    bean.totalToPay = toPayMoney;
    bean.waitPay = toPayMoney;
    bean.preToPay = preToPay;
  }

  /* 订单 控制栏 按钮 */
  static List<OrderControlBtModel> getOrderCtrlBts(OrderAbsBean item) {
    List<OrderControlBtModel> tempList = [];
    if (item.infoOrder.process == 0) {
      OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.cancel, "取消订单", UIColor.hex333, UIColor.hexBE);
      tempList.add(bt);
    }
    if (item.infoOrder.process == 3 && item.infoOrder.serviceItem == '1') {
      OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.reOrder, "续单", UIColor.fontLevel, UIColor.fontLevel);
      tempList.add(bt);
    }
    if (item.infoOrder.process >= 3 && item.infoOrder.process <= 7 && item.infoCaregiver != null && item.infoCaregiver.id > 0) {
      if ((item.infoOrder.status == 2 || item.infoOrder.status == 3) && item.infoOrder.serviceItem == '3') {
        OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.evaluateNurse, "评价", UIColor.hex333, UIColor.hexBE);
        tempList.add(bt);
      } else {
        OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.evaluateNormal, "评价", UIColor.hex333, UIColor.hexBE);
        tempList.add(bt);
      }
    }

    if ((item.infoOrder.status == 1 && item.infoOrder.process != 8) || item.infoOrder.status == 2) {
      var btText = item.infoOrder.status == 2 ? "支付尾款" : "立即付款";
      if (item.infoOrder.serviceItem == '3') {
        if (item.infoOrder.commissionpaystatus == 1) {
          OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.payNurseOrder, btText, UIColor.fontLevel, UIColor.fontLevel);
          tempList.add(bt);
        } else if (item.infoOrder.commissionpaystatus == 0) {
          OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.payNurseSalary, btText, UIColor.fontLevel, UIColor.fontLevel);
          tempList.add(bt);
        }
      } else {
        if (item.infoOrder.status == 2) {
          OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.tailPay, btText, UIColor.fontLevel, UIColor.fontLevel);
          tempList.add(bt);
        } else {
          var productDay = double.parse(item.infoOrder.productDays);
          if (productDay < 26) {
            OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.allPay, btText, UIColor.fontLevel, UIColor.fontLevel);
            tempList.add(bt);
          } else {
            OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.payNormal, btText, UIColor.fontLevel, UIColor.fontLevel);
            tempList.add(bt);
          }
        }
      }
    } else if (item.infoOrder.status == 3) {
      if (item.infoOrder.serviceItem == '3') {
        OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.payNurseSalary, "支付工资", UIColor.fontLevel, UIColor.fontLevel);
        tempList.add(bt);
      }
      if (item.chargeExtra != null && item.chargeExtra.totalMoneyTopay > 0) {
        OrderControlBtModel bt = OrderControlBtModel(OrderBtsType.payNurseSalary, "支付节日费用", UIColor.fontLevel, UIColor.fontLevel);
        tempList.add(bt);
      }
    }
    return tempList;
  }

  /* 订单类型 */
  static JJRoleType getOrderType(String serviceItem, {bool isEmpty = false}) {
    switch (serviceItem) {
      case '1': {
        if (isEmpty) return JJRoleType.shortMatron;
        return JJRoleType.matron;
      }
      case '2': return JJRoleType.cuiRu;
      case '3': return JJRoleType.nurse;
      case '99': return JJRoleType.other;
      default: return JJRoleType.unknown;
    }
  }

  /* 订单状态显示 */
  static String getStatusText(int process) {
    switch (process.toString()) {
      case '10': return "已退款";
      case '9': return "退款中";
      case '8': return "已取消";
      case '7': return "已评价";
      case '6': return "已评价";
      case '5': return "已评价";
      case '4': return "服务完成";
      case '3': return "服务中";
      case '2': return "等待服务";
      case '1': return "客户付款";
      case '0': return "未付款";
      default: return "未付款";
    }
  }
}