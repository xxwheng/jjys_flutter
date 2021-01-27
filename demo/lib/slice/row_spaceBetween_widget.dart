import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 单行  两个 左右分据 白色背景 底部有下划线 */
class RowSpaceBetweenWidget extends StatelessWidget {
  final Widget left;
  final Widget right;

  RowSpaceBetweenWidget({Key key, this.left, this.right}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AdaptUI.rpx(100),
      padding: EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [left, right],
      ),
    );
  }
}
