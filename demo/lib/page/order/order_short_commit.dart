import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/data/key_event_bus.dart';
import 'package:demo/model/order_short_product_bean.dart';
import 'package:demo/model/order_ys_price.dart';
import 'package:demo/network/dio/http_error.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/order_contact_ys.dart';
import 'package:demo/slice/order_server_short.dart';
import 'package:demo/slice/order_server_ys.dart';
import 'package:demo/slice/ys_wrap_filter.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/event_bus.dart';
import 'package:demo/utils/verify_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 短单提交
class OrderShortCommitPage extends StatefulWidget {
  @override
  _OrderShortCommitPageState createState() => _OrderShortCommitPageState();
}

class _OrderShortCommitPageState extends State<OrderShortCommitPage>
    with MultiDataLine {
  final String pageKey = "pageKey";
  final String priceKey = "orderPrice";

  /* 联系人 */
  OrderContactYsWidget _contactView;

  /* 预产期时间戳 */
  String _preDateStamp = "";

  /* 服务天数 */
  String _serviceDay = "1";

  /* 是否加半天 */
  bool isHalf = false;

  /* 宝宝数量 */
  int _num = 1;

  // 价格
  OrderPrice _orderPrice;

  // 产品列表
  List<Products> _productList;

  /* 备注 */
  TextEditingController _remarkController = TextEditingController();

  List<int> _serviceDayList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25
  ];

  /// 协议
  final String _keyProtocol = "key_protocol";
  bool _isProtocolTrue = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<bool>(pageKey).onLoading();
    loadProduct();
  }

  /* 加载产品信息*/
  void loadProduct() {
    Future.wait([
      XXNetwork.shared.post(params: {
        "methodName": "OrderPrice",
        "level": "3",
        "service_days": _serviceDay,
        "num": _num
      }),
      XXNetwork.shared
          .post(params: {"methodName": "ConfigProduct", "tag": "p2.2a"}),
    ]).then((valueArr) {
      return Future.wait([
        parseYsOrderPrice(valueArr[0]),
        parseOrderShortProductCompute(valueArr[1])
      ]);
    }).then((resArr) {
      _orderPrice = (resArr[0] as OrderYsPrice).orderPrice;
      _productList = (resArr[1] as OrderShortProductBean).products;
      getLine<bool>(pageKey).setData(true, true);
      getLine<OrderPrice>(priceKey).setData(_orderPrice, true);
    }).catchError((err) {
      logger.i(err);
      getLine<bool>(pageKey).onFailure();
    });
  }

  /* 服务天数 宝宝数量 更新订单金额 */
  void changeOrderPrice() {
    XXNetwork.shared.post(params: {
      "methodName": "OrderPrice",
      "service_days": _serviceDay,
      "num": _num
    }).then((value) {
      return parseYsOrderPrice(value);
    }).then((res) {
      _orderPrice = res.orderPrice;
      getLine<OrderPrice>(priceKey).setData(_orderPrice, true);
    });
  }

  List<ToastRow> toastRows() {
    return [
      ToastRow(_preDateStamp.isNotEmpty, "请选择预产期"),
      ToastRow(_contactView.getNickName.isNotEmpty, "请填写联系人姓名"),
      ToastRow(_contactView.getMobile.isNotEmpty, "请填写联系人电话"),
      ToastRow(_contactView.getMobile.length == 11, "请输入正确的联系电话"),
      ToastRow(_contactView.getTown.isNotEmpty, "请选择服务地区"),
      ToastRow(_contactView.getAddress.isNotEmpty, "请填写详细地址"),
      ToastRow(_isProtocolTrue, "请先阅读并同意服务协议")
    ];
  }

  /* 提交订单按钮  检测是否有未付款订单 --> 添加地址 --> 下单 */
  void commitOrderAction(tap) {
    if (!ToastUtil.judgeList(this.toastRows())) {
      return;
    }

    GlobalNet.orderCheckUnpay().then((_) {
      return XXNetwork.shared.post(params: {
        "methodName": "AddressAdd",
        "nickname": _contactView.getNickName,
        "mobile": _contactView.getMobile,
        "address": _contactView.getAddress,
        "provice": _contactView.getProvince,
        "city": _contactView.getCity,
        "town": _contactView.getTown,
        "default": "0",
      });
    }).then((value) {
      var addressId = value['id'].toString();
      return XXNetwork.shared.post(params: {
        "methodName": "OrderInsert",
        "level": _orderPrice.levelId,
        "address_id": addressId,
        "predict_day": _preDateStamp,
        "num": _num.toString(),
        "remark": _remarkController.text,
        "service_days": _serviceDay,
        "product_id": _orderPrice.productId,
        "coupon_id_user": "",
        "refer_id": "",
      });
    }).then((res) {
      /// 提交订单成功 --> 去支付页
      eventBus.emit(EventBusKey.orderListRefresh);
      var id = res['id'].toString();
      App.navigationTo(context, PageRoutes.ysOrderPayPage + "?id=$id");
    }).catchError((err) {
      print("异常");
      print(err);
      if (err.code == HttpError.OPERATOR_ERROR) {
        this.showUnPayAlert();
      }
    });
  }

  /* 未付款订单提示 */
  void showUnPayAlert() {
    showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: Text("温馨提示"),
            content: Container(
              padding: EdgeInsets.only(top: AdaptUI.rpx(10)),
              child: Text("您有订单未付款\n请到'我的订单'中处理"),
            ),
            actions: [
              CupertinoDialogAction(
                  child: Text(
                    '取消',
                    style: TextStyle(color: UIColor.hex666),
                  ),
                  onPressed: () => App.pop(context)),
              CupertinoDialogAction(
                  child: Text(
                    "我的订单",
                    style: TextStyle(color: UIColor.mainColor),
                  ),
                  onPressed: () => App.switchTabBar(context, 2))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提交订单"),
        centerTitle: true,
        elevation: 0,
      ),
      body: getLine<bool>(pageKey).addObserver(
          onRefresh: this.loadProduct,
          child: _chargeWidget(),
          builder: (ctx, data, priceWidget) {
            return Stack(
              children: [
                ListView(
                  children: [
                    _contactWidget(),
                    _serviceWidget(),
                    _productWidget(),
                    priceWidget,
                    _remarkWidget(),
                    _protocolWidget(),
                    Container(height: AdaptUI.rpx(120))
                  ],
                ),
                _commitWidget()
              ],
            );
          }),
    );
  }

  /* 联系人信息 */
  Widget _contactWidget() {
    if (_contactView == null) {
      _contactView = OrderContactYsWidget();
    }
    return _contactView;
  }

  /* 服务信息 */
  Widget _serviceWidget() {
    return OrderServerShortWidget(
      serviceDayArr: _serviceDayList.map((e) => e.toString()).toList(),
      onServiceDayCallBack: (serviceDay) {
        this._serviceDay = serviceDay;
        this.changeOrderPrice();
      },
      onPreDateCallBack: (preDate) {
        this._preDateStamp = preDate;
      },
      onBabyNumCallBack: (num) {
        this._num = num;
        this.changeOrderPrice();
      },
      onShortTap: () {},
    );
  }

  /* 产品价位 */
  Widget _productWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              top: AdaptUI.rpx(30),
              left: AdaptUI.rpx(30),
              bottom: AdaptUI.rpx(20)),
          child: Text(
            "月嫂价位",
            style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(30)),
          ),
        ),
        Container(
          width: AdaptUI.screenWidth,
            padding:
                EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
            decoration: BoxDecoration(color: Colors.white),
            child: YsWrapFilterWidget(
              list: this._productList?.map((e) => "${e.onePrice}元/天")?.toList(),
              iwidth: AdaptUI.rpx(180),
              iheight: AdaptUI.rpx(70),
              margin:
                  EdgeInsets.only(top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
              textColor: UIColor.mainColor,
              itemChanged: (index) {},
              decoration: (currentIndex, selectedIndex) {
                return BoxDecoration(
                    color: currentIndex == selectedIndex
                        ? UIColor.mainColor
                        : Colors.white,
                    border: Border.all(width: 1, color: UIColor.mainColor));
              },
            )),
      ],
    );
  }

  /* 费用 */
  Widget _chargeWidget() {
    return getLine<OrderPrice>(priceKey).addObserver(builder: (ctx, data, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: AdaptUI.rpx(30),
                left: AdaptUI.rpx(30),
                bottom: AdaptUI.rpx(20)),
            child: Text(
              "服务费用",
              style:
                  TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(30)),
            ),
          ),
          Container(
            height: AdaptUI.rpx(110),
            padding:
                EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _orderPrice.name,
                  style: TextStyle(fontSize: AdaptUI.rpx(30)),
                ),
                Text(
                  "￥${_orderPrice.priceCorp}元",
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(32), color: UIColor.fontLevel),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: AdaptUI.rpx(30),
                right: AdaptUI.rpx(30),
                top: AdaptUI.rpx(20),
                bottom: AdaptUI.rpx(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "温馨提示:",
                  style: TextStyle(fontSize: AdaptUI.rpx(30)),
                ),
                Container(
                  height: AdaptUI.rpx(20),
                ),
                Text(
                  "月子服务期间如遇国家法定节日（春节除外），需额外支付1倍工资，春节需额外支付2倍工资，请在月嫂开始服务当天另行支付。",
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(26), color: UIColor.fontLevel),
                )
              ],
            ),
          )
        ],
      );
    });
  }

  /* 备注 */
  Widget _remarkWidget() {
    return Container(
      margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AdaptUI.rpx(110),
            width: AdaptUI.screenWidth,
            padding: EdgeInsets.only(left: AdaptUI.rpx(30)),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
            child: Align(
              alignment: Alignment(-1, 0),
              child: Text(
                "备注",
                style: TextStyle(fontSize: AdaptUI.rpx(30)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(AdaptUI.rpx(30), AdaptUI.rpx(0),
                AdaptUI.rpx(30), AdaptUI.rpx(30)),
            height: AdaptUI.rpx(250),
            child: TextField(
              controller: _remarkController,
              style: TextStyle(fontSize: AdaptUI.rpx(30)),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "备注您的特殊要求，我们会尽量满足。"),
              maxLines: 10,
              maxLength: 200,
              buildCounter: (BuildContext ctx,
                  {int currentLength, int maxLength, bool isFocused}) {
                return Text(
                  "$currentLength/$maxLength",
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(24), color: UIColor.hex999),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /* 协议 */
  Widget _protocolWidget() {
    return Container(
      margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
      padding: EdgeInsets.only(left: AdaptUI.rpx(10)),
      height: AdaptUI.rpx(90),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTapUp: (_) {
              _isProtocolTrue = !_isProtocolTrue;
              getLine<bool>(_keyProtocol).setData(_isProtocolTrue);
            },
            child: Container(
              width: AdaptUI.rpx(80),
              height: AdaptUI.rpx(90),
              child: Center(
                child: getLine<bool>(_keyProtocol, initValue: _isProtocolTrue)
                    .addObserver(
                        builder: (ctx, data, _) => Image.asset(
                              data
                                  ? "images/ic_circle_sel.png"
                                  : "images/ic_circle.png",
                              width: AdaptUI.rpx(40),
                              height: AdaptUI.rpx(40),
                            )),
              ),
            ),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "同意",
                  style: TextStyle(
                      color: UIColor.hex666, fontSize: AdaptUI.rpx(30))),
              TextSpan(
                  text: "《家家月嫂服务协议》",
                  style: TextStyle(
                      color: UIColor.mainColor, fontSize: AdaptUI.rpx(30)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      App.navigationToProtocol(context, JJRoleType.matron);
                    }),
              TextSpan(
                  text: "相关条款",
                  style: TextStyle(
                      color: UIColor.hex666, fontSize: AdaptUI.rpx(30)))
            ]),
          )
        ],
      ),
    );
  }

  /* 提交 */
  Widget _commitWidget() {
    return Positioned(
      bottom: AdaptUI.safeABot,
      left: 0,
      right: 0,
      height: AdaptUI.rpx(100),
      child: GestureDetector(
        onTapUp: this.commitOrderAction,
        child: Container(
          color: UIColor.mainLight,
          child: Center(
            child: Text(
              "提交订单",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: AdaptUI.rpx(32),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }
}
