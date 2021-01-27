import 'package:adaptui/adaptui.dart';
import 'package:flutter/material.dart';

class XXCellWidget extends StatelessWidget {

  final double height;
  final Widget child;

  XXCellWidget({Key key, this.height, this.child}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AdaptUI.rpx(88),
      padding: AdaptUI.rpx(30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1.0, color: Color(0xffebedf0)))
      ),
      child: child,
    );
  }
}
