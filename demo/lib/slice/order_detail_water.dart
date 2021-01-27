import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/order_water_bean.dart';
import 'package:flutter/material.dart';

/* 订单流程表 */
class OrderDetailWaterWidget extends StatelessWidget {
  final List<WaterList> waterList;

  OrderDetailWaterWidget({Key key, this.waterList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
        color: Colors.white,
        child:
      Column(
        children: waterList.map((e) => Container(
          height: AdaptUI.rpx(150),
          child: Row(
            children: [
             VerticalDivider(
               indent: 1,
               endIndent: 1,
               thickness: 2,
               width: AdaptUI.rpx(60),
               color: Colors.red,
             ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.title, style: TextStyle(fontSize: AdaptUI.rpx(30), fontWeight: FontWeight.w500),),
                    Text(e.detail, style: TextStyle(fontSize: AdaptUI.rpx(26),))
                  ],
                ),
              )
            ],
          ),
        )).toList(),
      ),
    );
  }
}
