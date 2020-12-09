import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 工作排期 */
class YsDetailScheduleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
      padding: EdgeInsets.all(AdaptUI.rpx(30)),
      height: AdaptUI.rpx(360),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "工作排期",
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(32)),
                ),
              ),
              Text(
                "最近一年",
                style: TextStyle(
                    fontSize: AdaptUI.rpx(30), color: UIColor.hex666),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: AdaptUI.rpx(30),
                color: UIColor.hex999,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: AdaptUI.rpx(10), bottom: AdaptUI.rpx(10)),
            height: AdaptUI.rpx(180),
            child: PageView(
              controller: PageController(),
              children: [
                Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text("blur"),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: Center(
                    child: Text("blur"),
                  ),
                ),
                Container(
                  color: Colors.red,
                  child: Center(
                    child: Text("blur"),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AdaptUI.rpx(20),
                height: AdaptUI.rpx(20),
                color: UIColor.hex999,
                margin: EdgeInsets.only(right: AdaptUI.rpx(10)),
              ),
              Text("可预约"),
              Container(
                width: AdaptUI.rpx(20),
                height: AdaptUI.rpx(20),
                color: Color(0xffc398e3),
                margin: EdgeInsets.only(
                    left: AdaptUI.rpx(60), right: AdaptUI.rpx(10)),
              ),
              Text("已占用")
            ],
          )
        ],
      ),
    );
  }
}
