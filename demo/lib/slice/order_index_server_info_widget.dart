/* 订单列表
*  订单服务信息
*
* */

import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/order_data.dart';
import 'package:demo/model/order_index_bean.dart';
import 'package:demo/slice/ys_head_level.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:flutter/material.dart';

class OrderIndexServerInfoWidget extends StatelessWidget {

  final OrderIndexBean item;
  OrderIndexServerInfoWidget({Key key, this.item}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: AdaptUI.rpx(30),
          right: AdaptUI.rpx(30),
          top: AdaptUI.rpx(30),
          bottom: AdaptUI.rpx(30)),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoCaregiverHead(),
          Expanded(
            child: Container(
              padding:
              EdgeInsets.only(left: AdaptUI.rpx(30), top: AdaptUI.rpx(20)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _orderServerInfoWidget(item)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget  _infoCaregiverHead() {
    return YuesaoHeadLevelWidget(
      headUrl: item.infoOrder.serviceItem == '2' ? icCuiRu : item.infoCaregiver.icon,
      level: item.infoCaregiver.level,
      type: OrderDataTool.getOrderType(item.infoOrder.serviceItem,
          isEmpty: item.caregiverServer.isEmpty),
      careType: item.infoCaregiver.careType,
    );
  }

  /*  订单服务信息 */
  List<Widget> _orderServerInfoWidget(OrderIndexBean item) {
    if ((item.infoOrder.serviceItem == '1' ||
        item.infoOrder.serviceItem == '3')) {
      // 月嫂育婴师
      var dateText = item.infoOrder.serviceItem == '1' ? "预产期" : "预约时间";
      return [
        YuesaoNameAuthWidget(
          nickname: item.infoCaregiver.name,
          isCredit: item.infoCaregiver.isCredit == '1',
          style:
          TextStyle(fontSize: AdaptUI.rpx(36), fontWeight: FontWeight.w500),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
          child: Text(
            "金额: ￥${item.infoOrder.totalMoney}",
            style: TextStyle(fontSize: AdaptUI.rpx(30)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(5)),
          child: Text(
            "$dateText: ${item.infoOrder.scheduleDate}",
            style: TextStyle(fontSize: AdaptUI.rpx(30)),
          ),
        )
      ];
    } else if (item.infoOrder.serviceItem == '2') {
      return [
        Text(
          "服务级别: ${item.infoOrder.num}",
          style:
          TextStyle(fontSize: AdaptUI.rpx(36), fontWeight: FontWeight.w500),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
          child: Text(
            "金额: ￥${item.infoOrder.totalMoney}",
            style: TextStyle(fontSize: AdaptUI.rpx(30)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(5)),
          child: Text(
            "预约时间: ${item.infoOrder.scheduleDate}",
            style: TextStyle(fontSize: AdaptUI.rpx(30)),
          ),
        )
      ];
    } else if (item.infoOrder.serviceItem == '99') {
      return [
        Text(
          "套餐类型: ${item.infoOrder.attribute ?? ''}",
          style:
          TextStyle(fontSize: AdaptUI.rpx(36), fontWeight: FontWeight.w500),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
          child: Text(
            "金额: ￥${item.infoOrder.totalMoney}",
            style: TextStyle(fontSize: AdaptUI.rpx(30)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(5)),
          child: Text(
            "预约时间: ${item.infoOrder.scheduleDate}",
            style: TextStyle(fontSize: AdaptUI.rpx(30)),
          ),
        )
      ];
    } else {
      return [];
    }
  }
}
