import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/model/order_pay_info_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/radio_list_view.dart';
import 'package:demo/slice/row_spaceBetween_widget.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/data_line.dart';
import 'package:flutter/material.dart';
import 'package:xx_pay/alipay_result_bean.dart';
import 'package:xx_pay/xx_pay.dart';

/* 月嫂订单支付 */
class OrderYsPayPage extends StatefulWidget {
  final String id;

  OrderYsPayPage({Key key, this.id}) : super(key: key);

  @override
  _OrderYsPayPageState createState() => _OrderYsPayPageState();
}

class _OrderYsPayPageState extends State<OrderYsPayPage> with MultiDataLine {
  final String key = "order_key";
  OrderPayInfoBean _payInfoBean;

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
//    return;
    XXNetwork.shared.post(params: {
      "methodName": "OrderPayStart",
      "order_id": widget.id,
      "type": 1,
      "channel": "alipay",
      "extra_pay": "0",
      "charge_type": 2,
      "app_id": "2018053160301392"
    }).then((value) {
      var payUrl = value["charge_wx"]["mweb_url"].toString();
      logger.i(payUrl);
      return XxPay.aliPay(payUrl, "JJYSAlipay");
    }).then((res) {
      switch (res.code) {
        case AliPayCode.succeed:
          break;
        case AliPayCode.cancelled:
          break;
        default:

          break;
      }
    });
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
          RadioListView(children: [
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

  /* 支付金额 */
  Widget _sectionPayWidget() {
    return sectionWidget(
        title: "支付金额",
        child: Column(
          children: [
            RadioListView(
              beginIndex: 1,
              indexCallBack: (index) {
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
