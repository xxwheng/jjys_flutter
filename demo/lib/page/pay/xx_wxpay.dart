import 'dart:async';
import 'dart:convert';
import 'package:demo/common/common.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/utils/v_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:xx_pay/wxpay_result_bean.dart';
import 'package:xx_pay/xx_pay.dart';

// wx4ac4c47ec2e975db
class XXWXPay {
  /// orderId 订单id
  /// type 支付类型[1定金2尾款3全款4限额支付]
  static Future<void> pay(BuildContext context, String orderId, int type) async {

    logger.i("订单id:  $orderId \n支付渠道： 微信\n支付类型:  ${type == 3 ? '全款' : (type == 1 ? '订金' : '尾款')}");

    Completer _complete = Completer();
    XXNetwork.shared.post(params: {
      "methodName": "OrderPayStart",
      "order_id": orderId,
      "type": type,           // 支付类型[1定金2尾款3全款4限额支付]
      "channel": "wx", //支付渠道
      "extra_pay": "0", // 是否包括节假日费用
      "charge_type": 2, // >1 原生支付
      "app_id": "wx4ac4c47ec2e975db"
    }).then((value) {
      var wxParams = json.decode(value["charge_wx"]["mweb_url"]);
      var partnerId = wxParams["partnerid"].toString();
      var prepayId = wxParams["prepayid"].toString();
      var timeStamp = wxParams["timestamp"].toString();
      var nonceStr = wxParams["noncestr"].toString();
      var package = wxParams["package"].toString();
      var sign = wxParams["sign"].toString();
      return XxPay.wxPay(partnerId, prepayId, package, nonceStr, timeStamp, sign);
    }).then((res) {
      if (res == null) {
        VToast.show("支付平台异常");
        return;
      }
      switch (res.code) {
        case WXErrCode.success:
          VToast.show("支付成功");
          _complete.complete();
          App.switchTabBar(context, 2);
          break;
        case WXErrCode.cancel:
          VToast.show("支付取消");
          break;
        default:
          VToast.show("支付失败");
          break;
      }
    }).catchError((err){
      logger.i(err);
    });
  }
}