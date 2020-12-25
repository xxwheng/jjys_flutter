import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/model/order_ys_price.dart';
import 'package:demo/model/ys_min_bean.dart';
import 'package:demo/network/dio/http_error.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/order_contact_ys.dart';
import 'package:demo/slice/order_server_ys.dart';
import 'package:demo/slice/ys_head_level.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/verify_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OrderYsCommitPage extends StatefulWidget {
  final String id;

  OrderYsCommitPage({Key key, this.id}) : super(key: key);

  @override
  _OrderYsCommitPageState createState() => _OrderYsCommitPageState();
}

class _OrderYsCommitPageState extends State<OrderYsCommitPage>
    with MultiDataLine {
  final String key = "viewKey";

  YsMinBean _ysMinBean;
  OrderPrice _orderPrice;
  List<String> _serviceDayList;

  /* 预产期时间戳 */
  String _preDateStamp = "";
  /* 服务天数 */
  String _serviceDay = "26";
  /* 宝宝数量 */
  int _num = 1;

  /* 备注 */
  TextEditingController _remarkController = TextEditingController();

  /// 协议
  final String _keyProtocol = "key_protocol";
  bool _isProtocolTrue = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<YsMinBean>(key).onLoading();
    loadYueSaoViewMin();
  }

  /* 加载服务月嫂信息*/
  void loadYueSaoViewMin() {
    Future.wait([
      XXNetwork.shared.post(
          params: {"methodName": "YuesaoViewMin", "yuesao_id": widget.id}),
      XXNetwork.shared.post(params: {
        "methodName": "OrderPrice",
        "yuesao_id": widget.id,
        "service_days": 26,
        "num": 1
      }),
      XXNetwork().post(params: {"methodName": "ConfigServiceDay"})
    ]).then((valueArr) {
      return Future.wait([
        parseOrderYsMinCompute(valueArr[0]),
        parseYsOrderPrice(valueArr[1]),
        parseListStringCompute(valueArr[2]['service_day'])
      ]);
    }).then((resArr) {
      _ysMinBean = resArr[0];
      _orderPrice = (resArr[1] as OrderYsPrice).orderPrice;
      _serviceDayList = resArr[2];
      getLine<YsMinBean>(key).setData(_ysMinBean);
    }).catchError((err) {
      logger.i(err);
      getLine<YsMinBean>(key).onFailure();
    });
  }

  List<ToastRow> toastRows() {
    return [
      ToastRow(_preDateStamp.isNotEmpty, "请选择预产期"),
      ToastRow(_contactView.getNickName.isNotEmpty, "请填写联系人姓名"),
      ToastRow(_contactView.getMobile.isNotEmpty, "请填写联系人电话"),
      ToastRow(_contactView.getMobile.length==11, "请输入正确的联系电话"),
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
        "yuesao_id": _ysMinBean.id,
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
      /// 提交订单成功
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

    showCupertinoDialog(context: context, builder: (ctx) {
      return CupertinoAlertDialog(
        title: Text("温馨提示"),
        content: Container(
          padding: EdgeInsets.only(top: AdaptUI.rpx(10)),
          child: Text("您有订单未付款\n请到'我的订单'中处理"),
        ) ,
        actions: [
          CupertinoDialogAction(child: Text('取消', style: TextStyle(color: UIColor.hex666),), onPressed: () => App.pop(context)),
          CupertinoDialogAction(child: Text("我的订单", style: TextStyle(color: UIColor.mainColor),), onPressed: () => App.switchTabBar(context, 2))
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
      body: getLine<YsMinBean>(key).addObserver(builder: (ctx, data, _) {
        return Stack(
          children: [
            ListView(
              children: [
                _ysViewMinWidget(),
                _serviceWidget(),
                _contactWidget(),
                _chargeWidget(),
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

  /* 提交 */
  Widget _commitWidget() {
    return Positioned(
        bottom: AdaptUI.safeABot,
        left: 0,
        right: 0,
        height: AdaptUI.rpx(100),
        child: GestureDetector(
          onTapUp:  this.commitOrderAction,
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
        ));
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
                    ..onTap = () { App.navigationToProtocol(context, JJRoleType.matron); }
              ),
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

  /* 费用 */
  Widget _chargeWidget() {
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
            style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(30)),
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
                "住家月子服务",
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
  }

  OrderContactYsWidget _contactView;

  /* 联系人信息 */
  Widget _contactWidget() {
    if (_contactView == null) {
      _contactView = OrderContactYsWidget();
    }
    return _contactView;
  }

  /* 服务信息 */
  Widget _serviceWidget() {
    return OrderServerYsWidget(
      serviceDayArr: _serviceDayList,
      onServiceDayCallBack: (serviceDay) => this._serviceDay = serviceDay,
      onPreDateCallBack: (preDate) => this._preDateStamp = preDate,
      onBabyNumCallBack: (num) => this._num = num,
      onShortTap: () {},
    );
  }

  /* 月嫂信息 */
  Widget _ysViewMinWidget() {
    return Container(
      padding: EdgeInsets.all(AdaptUI.rpx(30)),
      color: Colors.white,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        YuesaoHeadLevelWidget(
            headUrl: _ysMinBean.icon, level: _ysMinBean.level),
        Container(
          padding: EdgeInsets.only(left: AdaptUI.rpx(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: AdaptUI.rpx(35),
              ),
              YuesaoNameAuthWidget(
                nickname: _ysMinBean.name,
                isCredit: _ysMinBean.isCredit == "1",
                style: TextStyle(
                    fontSize: AdaptUI.rpx(36), fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text("服务项目:"),
                  Text(
                    _orderPrice.name,
                    style: TextStyle(
                        fontSize: AdaptUI.rpx(36), fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
