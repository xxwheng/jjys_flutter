import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

/// 底部控制栏 （safe安全域）
class SafeBottomControlWidget extends StatelessWidget {

  final double height;
  final List<Widget> children;

  SafeBottomControlWidget({Key key, this.height, this.children}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height+AdaptUI.safeABot,
      color: UIColor.pageColor,
      child: Container(
        height: height,
        color: Colors.white,
        child: Row(
          children: children,
        ),
      ),
    );
  }
}
