import 'package:demo/data/global_data.dart';

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

class OrderDataTool {

  /* 订单类型 */
  static JJRoleType getOrderType(String serviceItem, {bool isEmpty = false}) {
    if (isEmpty) return JJRoleType.unknown;
    switch (serviceItem) {
      case '1': return JJRoleType.matron;
      case '2': return JJRoleType.cuiRu;
      case '3': return JJRoleType.nurse;
      case '99': return JJRoleType.other;
      default: return JJRoleType.unknown;
    }
  }

  /* 订单状态显示 */
  static String getStatusText(String process) {
    switch (process) {
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
      case '0': return "已退款";
      default: return "未付款";
    }
  }
}