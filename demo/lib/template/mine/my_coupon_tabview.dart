import 'package:adaptui/adaptui.dart';
import 'package:date_format/date_format.dart';
import 'package:demo/common/color.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/model/my_coupon_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:flutter/material.dart';

class MyCouponTableView extends StatefulWidget {
  /// type 类型  1未使用  2已使用   3已过期
  final int type;

  MyCouponTableView({Key key, this.type}) : super(key: key);

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

  Color get _textColor {
    return widget.type > 1 ? UIColor.hexBE : UIColor.hex333;
  }
  
  /* 标记图片 */
  Widget _getCouponTypeImage() {
    switch (widget.type) {
      case 1:
        return null;
      case 2:
        return Image.asset("images/coupon_used.png", fit: BoxFit.contain, width: AdaptUI.rpx(101),height: AdaptUI.rpx(76),);
      case 3:
        return Image.asset("images/coupon_late.png", fit: BoxFit.contain, width: AdaptUI.rpx(101),height: AdaptUI.rpx(76),);
      default:
        return null;
    }
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
      var tempList = (value['data'] as List)
          ?.map((e) => null == e ? null : MyCouponBean.fromJson(e))
          ?.toList();
      var page = int.parse(value['page'].toString());
      var total = int.parse(value['total'].toString());
      addList(tempList, page, total);
    }).catchError((e) => this.endRefreshing(status: false));
  }

  @override
  void addList(List list, int page, int total) {
    // TODO: implement addList
    super.addList(list, page, total);
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return PageRefreshWidget(
        pageDataSource: this,
        child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          MyCouponBean bean = this.list[index];
          return Container(
            margin: EdgeInsets.only(
                top: AdaptUI.rpx(20),
                left: AdaptUI.rpx(30),
                right: AdaptUI.rpx(30)),
            padding: EdgeInsets.only(right: AdaptUI.rpx(10)),
            height: AdaptUI.rpx(210),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(AdaptUI.rpx(20))),
              border: Border.all(color: UIColor.hexEEE),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: AdaptUI.rpx(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(AdaptUI.rpx(20)), bottomLeft: Radius.circular(AdaptUI.rpx(20))),
                        color: UIColor.hexBE
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Center(
                          child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: "￥", style: TextStyle(fontSize: AdaptUI.rpx(26), color: _textColor)),
                                TextSpan(text: bean.info.money, style: TextStyle(fontSize: AdaptUI.rpx(50), fontWeight: FontWeight.w500, color: _textColor))
                              ]
                          ),
                          ),
                          ),),
                    Container(
                      margin: EdgeInsets.only(right: AdaptUI.rpx(10)),
                      child: Image.asset("images/coupon_line.png", width: AdaptUI.rpx(10), height: AdaptUI.rpx(210), fit: BoxFit.cover,),
                    ),
                    Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.label_outline,
                                  size: AdaptUI.rpx(30),
                                  color: UIColor.hex999,
                                ),
                                Expanded(child:
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(bean.info.title, overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: AdaptUI.rpx(30), color: _textColor)),
                                ))
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: AdaptUI.rpx(30)+5),
                              child: Text(
                                bean.info.notes,
                                style: TextStyle(fontSize: AdaptUI.rpx(28), color: _textColor),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: AdaptUI.rpx(28),
                                  color: UIColor.hex999,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text("有效期至${bean.endTime}",
                                      style: TextStyle(fontSize: AdaptUI.rpx(28), color: _textColor)),
                                )
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
                Align(
                  alignment: Alignment(1,-0.85),
                  child: _getCouponTypeImage(),
                )
              ],
            ) 
          );
        }));
  }
}
