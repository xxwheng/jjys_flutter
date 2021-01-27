import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/* 单行 cell 白色背景 底部有下划线 */
class CellRowWidget extends StatelessWidget {

  final VoidCallback onTapUp;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  CellRowWidget({Key key, this.children, this.mainAxisAlignment, this.onTapUp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTapUp,
        child: Container(
          height: AdaptUI.rpx(100),
          padding:
              EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
          decoration: BoxDecoration(
            color: Colors.white,
              border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
          child: Row(
            mainAxisAlignment:
                mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ));
  }
}
