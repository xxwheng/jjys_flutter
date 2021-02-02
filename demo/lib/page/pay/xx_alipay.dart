
import 'dart:async';

import 'package:demo/common/common.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/utils/v_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:xx_pay/alipay_result_bean.dart';
import 'package:xx_pay/xx_pay.dart';

/// 支付宝支付
class XXAliPay {

  /// orderId 订单id
  /// type 支付类型[1定金2尾款3全款4限额支付]
  static Future<void> pay(BuildContext context, String orderId, int type) async {

    logger.i("订单id:  $orderId \n支付渠道： 支付宝\n支付类型:  ${type == 3 ? '全款' : (type == 1 ? '订金' : '尾款')}");

    Completer _complete = Completer();
    XXNetwork.shared.post(params: {
      "methodName": "OrderPayStart",
      "order_id": orderId,
      "type": type,           // 支付类型[1定金2尾款3全款4限额支付]
      "channel": "alipay", //支付渠道
      "extra_pay": "0", // 是否包括节假日费用
      "charge_type": 2, // >1 原生支付
      "app_id": "2018053160301392"
    }).then((value) {
      var payUrl = value["charge_wx"]["mweb_url"].toString();
      logger.i(payUrl);
      return XxPay.aliPay(payUrl, "JJYSAlipay");
    }).then((res) {
      if (res == null) {
        VToast.show("支付平台异常");
        return;
      }
      switch (res.code) {
        case AliPayCode.succeed:
          VToast.show("支付成功");
          _complete.complete();
          App.switchTabBar(context, 2);
          break;
        case AliPayCode.cancelled:
          VToast.show("支付取消");
          break;
        default:
          VToast.show("支付失败");
          break;
      }
    }).catchError((err){

    });
  }
}