import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 服务内容 */
class YsDetailServiceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
        padding: EdgeInsets.all(AdaptUI.rpx(30)),
        color: Colors.white,
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "服务内容",
                  style: TextStyle(fontSize: AdaptUI.rpx(32)),
                ),
              ),
              Text(
                "查看更多",
                style:
                    TextStyle(fontSize: AdaptUI.rpx(30), color: UIColor.hex666),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: AdaptUI.rpx(30),
                color: UIColor.hex999,
              )
            ],
          ),
          Container(
            height: AdaptUI.rpx(30),
          ),
          Wrap(
            spacing: AdaptUI.rpx(14),
            runSpacing: AdaptUI.rpx(20),
            children: ["基本护理", "科学喂养", "宝宝早教", "产后恢复", "月子餐", "母婴护理"].map((e) {
              return Container(
                width: AdaptUI.rpx(220),
                height: AdaptUI.rpx(240),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: AdaptUI.rpx(10)),
                      width: AdaptUI.rpx(220),
                      height: AdaptUI.rpx(180),
                      color: Colors.red,
                    ),
                    Text(
                      e,
                      style: TextStyle(
                          fontSize: AdaptUI.rpx(30), color: UIColor.hex666),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ]));
  }
}
