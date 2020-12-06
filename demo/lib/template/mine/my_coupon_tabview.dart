import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/model/my_coupon_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:flutter/material.dart';

class MyCouponTableView extends StatefulWidget {

  /// type 类型  1未使用  2已使用   3已过期
  final int type;
  MyCouponTableView({Key key, this.type}): super(key: key);

  @override
  _MyCouponTableViewState createState() => _MyCouponTableViewState();
}

class _MyCouponTableViewState extends State<MyCouponTableView>
    with PageDataSource<MyCouponBean>, AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
  }

  @override
  void loadPageData() {
    // TODO: implement loadPageData
    super.loadPageData();
    XXNetwork.shared.post(params: {
      "methodName": "CouponList",
      "type": widget.type,
      "page": this.page,
      "size": this.size,
    }).then((value) {
      var tempList = (value['data'] as List)?.map((e) => null == e ? null : MyCouponBean.fromJson(e))?.toList();
      var page = int.parse(value['page'].toString());
      var total = int.parse(value['total'].toString());
      addList(tempList, page, total, setState);
    }).catchError((e) => this.endRefreshing(status: false));
  }

  @override
  void addList(List list, int page, int total, Function setState) {
    // TODO: implement addList
    super.addList(list, page, total, setState);
  }

  @override
  Widget build(BuildContext context) {
    return PageRefreshWidget(
        pageDataSource: this, itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(top: AdaptUI.rpx(30),
            left: AdaptUI.rpx(30),
            right: AdaptUI.rpx(30)),
        height: AdaptUI.rpx(190),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(AdaptUI.rpx(10))),
          border: Border.all(color: UIColor.hexEEE),
        ),
        child: Row(
          children: [
            Expanded(flex: 3, child: Center(child: Text("￥300"),)),
            Expanded(flex: 7, child: Column(
              children: [
                Row(children: [Icon(Icons.label_outline), Text("育婴师优惠券",)],),
                Text("仅限用于家家育婴师订单，不可提现，不可转让"),
                Row(
                  children: [Icon(Icons.timer), Text("有效期至2018/4/25 14:30",)],),
              ],
            )),
          ],
        ),
      );
    });
  }
}
