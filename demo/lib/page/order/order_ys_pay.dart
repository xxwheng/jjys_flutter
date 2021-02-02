import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/data/order_data.dart';
import 'package:demo/model/order_pay_info_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/pay/xx_alipay.dart';
import 'package:demo/page/pay/xx_wxpay.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/radio_list_view.dart';
import 'package:demo/slice/row_spaceBetween_widget.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/data_line.dart';
import 'package:demo/utils/v_toast.dart';
import 'package:flutter/material.dart';
import 'package:xx_pay/alipay_result_bean.dart';
import 'package:xx_pay/xx_pay.dart';

/* 月嫂订单支付 */
class OrderYsPayPage extends StatefulWidget {
  final String id;
  final OrderPayType payType;

  OrderYsPayPage({Key key, this.id, this.payType = OrderPayType.payNormal}) : super(key: key);

  @override
  _OrderYsPayPageState createState() => _OrderYsPayPageState();
}

class _OrderYsPayPageState extends State<OrderYsPayPage> with MultiDataLine {
  final String key = "order_key";
  OrderPayInfoBean _payInfoBean;
  /// 可选择的时候， 是全款还是订金  [1定金2尾款3全款4限额支付]
  var normalType = 3;
  /// 默认支付宝支付
  JJPayType channel = JJPayType.aliPay;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<bool>(key).onLoading();
    loadOrderPayInfo();
  }

  /* 加载订单支付信息 */
  void loadOrderPayInfo() {
    XXNetwork.shared.post(params: {
      "methodName": "OrderPayInfo",
      "order_id": widget.id
    }).then((value) {
      return parseYsOrderPayInfo(value);
    }).then((bean) {
      _payInfoBean = bean;
      getLine<bool>(key).setData(true, true);
    }).catchError((err) {
      logger.i(err);
      getLine<bool>(key).setState(LineState.failure);
    });
  }

  /* 点击支付 */
  void payDidTap(tap) {
    var type = 3;
    if (widget.payType == OrderPayType.payNormal) {
      type = this.normalType;
    } else if (widget.payType == OrderPayType.tailPay) {
      type = 2;
    }

    if (this.channel == JJPayType.aliPay) {
      /// 支付宝支付
      XXAliPay.pay(context, widget.id, type).then((value) {
        /// 支付成功
      });
    } else {
      /// 微信支付
      XXWXPay.pay(context, widget.id, type).then((value) {
        /// 支付成功

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("确认支付"),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: UIColor.pageColor,
      body: getLine<bool>(key).addObserver(
          onRefresh: loadOrderPayInfo,
          builder: (ctx, _, __) {
            return Stack(
              children: [
                ListView(
                  children: [
                    _sectionTotalWidget(),
                    _sectionPayWidget(),
                    _sectionPayType(),
                    Container(height: AdaptUI.rpx(120))
                  ],
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: AdaptUI.rpx(100),
                  child: GestureDetector(
            onTapUp: this.payDidTap,
            child: Container(
              color: UIColor.mainLight,
              child: Center(
                  child: Text(
                    "确认支付",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: AdaptUI.rpx(32),
                        fontWeight: FontWeight.w500),
                  )),
            ),
            ) ,
                )
              ],
            );
          }),
    );
  }

  /* 支付方式 */
  Widget _sectionPayType() {
    return sectionWidget(
      title: "支付方式",
      child: Column(
        children: [
          RadioListView(
              indexCallBack: (index) {
                /// 切换支付方式
                this.channel = jjPayType(index);
              },
              children: [
            payRowWidget(JJPayType.aliPay),
            payRowWidget(JJPayType.wxPay)
          ]),
          Container(
              height: AdaptUI.rpx(80),
              child: Center(
                child: Text(
                  "请在两小时内完成付款,否则订单将被取消",
                  style:
                      TextStyle(fontSize: AdaptUI.rpx(28), color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
          )
        ],
      ),
    );
  }

  /* 支付方式单行 */
  Widget payRowWidget(JJPayType type) {
    String icName = "";
    String title = "";
    String content = "";
    switch (type) {
      case JJPayType.aliPay:
        icName = "images/ic_zhifubao.png";
        title = "支付宝支付";
        content = "推荐安装支付宝客户端的用户使用";
        break;
      case JJPayType.wxPay:
        icName = "images/ic_weixin.png";
        title = "微信支付";
        content = "推荐安装微信客户端的用户使用";
        break;
      default:
        break;
    }

    return Container(
      padding: EdgeInsets.only(
          left: AdaptUI.rpx(30), top: AdaptUI.rpx(20), bottom: AdaptUI.rpx(20)),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: AdaptUI.rpx(20)),
            child: Image.asset(
              icName,
              width: AdaptUI.rpx(60),
              height: AdaptUI.rpx(60),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(30), color: UIColor.hex333)),
              Text(content,
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(26), color: UIColor.hex666))
            ],
          )
        ],
      ),
    );
  }

  final String keyPayMoney = "pay_money";

  /// 三种类型 （订金、全款） （全款） （尾款）
  /* 支付金额 */
  Widget _sectionPayWidget() {
    switch(widget.payType) {
      case OrderPayType.payNormal:
        return _sectionPayNormalWidget();
      case OrderPayType.allPay:
        return _sectionPayAllWidget();
      case OrderPayType.tailPay:
        return _sectionPayTail();
    }
  }

  /// （尾款）
  Widget _sectionPayTail() {
    return sectionWidget(
        title: "支付金额",
        child: Column(
          children: [
            RadioListView(
              children: [
                RowSpaceBetweenWidget(
                  left: Text("支付尾款"),
                  right: Text("￥${_payInfoBean.infoOrder.totalToPay}元"),
                )
              ],
            ),
            RowSpaceBetweenWidget(
              left: Text("总金额",
                  style: TextStyle(
                      color: UIColor.fontLevel, fontWeight: FontWeight.w500)),
              right: getLine<String>(keyPayMoney,
                  initValue: "${_payInfoBean.infoOrder.totalToPay}")
                  .addObserver(builder: (ctx, data, _) {
                return Text("￥$data元",
                    style: TextStyle(
                        color: UIColor.fontLevel, fontWeight: FontWeight.w500));
              }),
            )
          ],
        ));
  }


  /// （全款）
  Widget _sectionPayAllWidget() {
    return sectionWidget(
        title: "支付金额",
        child: Column(
          children: [
            RadioListView(
              children: [
                RowSpaceBetweenWidget(
                  left: Text("支付全款"),
                  right: Text("￥${_payInfoBean.infoOrder.totalToPay}元"),
                )
              ],
            ),
            RowSpaceBetweenWidget(
              left: Text("总金额",
                  style: TextStyle(
                      color: UIColor.fontLevel, fontWeight: FontWeight.w500)),
              right: getLine<String>(keyPayMoney,
                  initValue: "${_payInfoBean.infoOrder.totalToPay}")
                  .addObserver(builder: (ctx, data, _) {
                return Text("￥$data元",
                    style: TextStyle(
                        color: UIColor.fontLevel, fontWeight: FontWeight.w500));
              }),
            )
          ],
        ));
  }

  /// （订金、全款）
  Widget _sectionPayNormalWidget() {
    return sectionWidget(
        title: "支付金额",
        child: Column(
          children: [
            RadioListView(
              beginIndex: 1,
              indexCallBack: (index) {
                this.normalType = index == 0 ? 1 : 3;
                getLine<String>(keyPayMoney).setData(index == 0
                    ? _payInfoBean.infoOrder.preToPay
                    : "${_payInfoBean.infoOrder.totalToPay}");
              },
              children: [
                RowSpaceBetweenWidget(
                  left: Text("支付订金(全款20%)"),
                  right: Text("￥${_payInfoBean.infoOrder.preToPay}元"),
                ),
                RowSpaceBetweenWidget(
                  left: Text("支付全款"),
                  right: Text("￥${_payInfoBean.infoOrder.totalToPay}元"),
                )
              ],
            ),
            RowSpaceBetweenWidget(
              left: Text("总金额",
                  style: TextStyle(
                      color: UIColor.fontLevel, fontWeight: FontWeight.w500)),
              right: getLine<String>(keyPayMoney,
                      initValue: "${_payInfoBean.infoOrder.totalToPay}")
                  .addObserver(builder: (ctx, data, _) {
                return Text("￥$data元",
                    style: TextStyle(
                        color: UIColor.fontLevel, fontWeight: FontWeight.w500));
              }),
            )
          ],
        ));
  }

  /* 费用合计*/
  Widget _sectionTotalWidget() {
    return sectionWidget(
        title: "费用合计",
        child: RowSpaceBetweenWidget(
          left: Text(_payInfoBean.infoOrder.title),
          right: Text("￥${_payInfoBean.infoOrder.productPrice}元"),
        ));
  }

  /* 标题模块 */
  Widget sectionWidget({String title, Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Color.fromARGB(255, 248, 248, 248),
          padding: EdgeInsets.only(
              top: AdaptUI.rpx(30),
              left: AdaptUI.rpx(30),
              bottom: AdaptUI.rpx(20)),
          child: Text(
            title,
            style: TextStyle(fontSize: AdaptUI.rpx(32), color: UIColor.hex666),
          ),
        ),
        Container(
          child: child,
          color: Colors.white,
        )
      ],
    );
  }
}
