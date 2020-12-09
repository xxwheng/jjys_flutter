import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/web_url_bridge.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/template/mine/my_coupon_tabview.dart';
import 'package:demo/utils/dialog/coupon_dialog.dart';
import 'package:demo/utils/v_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* 我的优惠券列表 */
class MyCouponListPage extends StatefulWidget {
  @override
  _MyCouponListPageState createState() => _MyCouponListPageState();
}

class _MyCouponListPageState extends State<MyCouponListPage> {

  TabController _controller;

  final List<Widget> _tabWidgetList = [Text("未使用"), Text("已使用"), Text("已过期")];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
        length: this._tabWidgetList.length, vsync: ScrollableState());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  /* 优惠券使用规则 */
  void _couponRuleTap() {
    App.navigationToWeb(context, "优惠券使用规则", kUrlRegisterProtocol);
  }

  void _reqExchangeCoupon(String code) {
    if (code.isEmpty) {
      VToast.show("请输入兑换码");
      return;
    }
    XXNetwork.shared
        .post(params: {"code": code, "methodName": "CouponPwChange"}).then((value) {
          /// 兑换成功
      VToast.show("兑换成功");
      _dialog.hide();
    });
  }

  CouponDialog _dialog;

  void _showDialog() {
    if (null == _dialog) {
      _dialog = CouponDialog();
      _dialog.tapCallBack = _reqExchangeCoupon;
    }
    _dialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("我的优惠券"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _showDialog,
            child: Container(
              margin: EdgeInsets.only(
                  left: AdaptUI.rpx(30),
                  right: AdaptUI.rpx(30),
                  top: AdaptUI.rpx(48)),
              height: AdaptUI.rpx(90),
              padding: EdgeInsets.only(
                  left: AdaptUI.rpx(30), right: AdaptUI.rpx(10)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: UIColor.hexEEE),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Icon(
                    Icons.label_rounded,
                    size: AdaptUI.rpx(50),
                    color: UIColor.mainColor,
                  ),
                  Expanded(
                      child: Text(
                    "兑换优惠券",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: UIColor.mainColor),
                  )),
                  Icon(
                    Icons.navigate_next,
                    color: UIColor.hex999,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _couponRuleTap,
            child: Container(
              padding: EdgeInsets.only(
                  top: AdaptUI.rpx(20),
                  right: AdaptUI.rpx(40),
                  bottom: AdaptUI.rpx(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.help_outline,
                    size: AdaptUI.rpx(40),
                    color: UIColor.hex999,
                  ),
                  Text(
                    "  使用规则",
                    style: TextStyle(
                        fontSize: AdaptUI.rpx(28), color: UIColor.hex666),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: AdaptUI.rpx(100),
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: UIColor.hex666,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: UIColor.mainColor,
              tabs: _tabWidgetList
                  .asMap()
                  .keys
                  .map((e) => _tabWidgetList[e])
                  .toList(),
              controller: _controller,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: _tabWidgetList
                  .asMap()
                  .keys
                  .map((e) => MyCouponTableView(
                        type: e + 1,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
