import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/template/mine/my_coupon_tabview.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("我的优惠券"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: AdaptUI.rpx(30),
                right: AdaptUI.rpx(30),
                top: AdaptUI.rpx(48)),
            height: AdaptUI.rpx(80),
            padding:
                EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(10)),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: UIColor.hexEEE),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Icon(
                  Icons.label_rounded,
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
                  color: UIColor.hexEEE,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: AdaptUI.rpx(20),
                right: AdaptUI.rpx(40),
                bottom: AdaptUI.rpx(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.help_outline,
                  color: UIColor.hex666,
                ),
                Text("  使用规则")
              ],
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
                children: _tabWidgetList.asMap().keys.map((e) => MyCouponTableView(type: e+1,)).toList(),
          ),),
        ],
      ),
    );
  }

}
