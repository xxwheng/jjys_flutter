import 'dart:ui';

import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';


class YsFilterSlice {
  static Widget pickerText(String text, [String place]) {
    text ??= '';
    place ??= '';
    return Text(text.isEmpty?place:text, style: TextStyle(fontSize: AdaptUI.rpx(30), color: text.isEmpty?UIColor.hex999:UIColor.hex333),);
  }
}

/* 月嫂列表筛选 选择栏 */
class YsFilterPickerRowWidget extends StatefulWidget {
  final double height;

  final Color rowColor = Colors.white;

  final String title;

  final Widget child;

  final GestureTapUpCallback tapAction;

  YsFilterPickerRowWidget({Key key, this.height, this.title, this.child, this.tapAction}): super(key: key);


  @override
  _YsFilterPickerRowWidgetState createState() => _YsFilterPickerRowWidgetState();
}

class _YsFilterPickerRowWidgetState extends State<YsFilterPickerRowWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AdaptUI.rpx(30)),
      height: widget.height ?? AdaptUI.rpx(80),
      decoration: BoxDecoration(
        color: widget.rowColor,
          border: Border(
              bottom: BorderSide(
                  color: UIColor.hexEEE, width: 0.5))),
      child: GestureDetector(
        onTapUp: widget.tapAction,
        child: Container(
          padding: EdgeInsets.only(right: AdaptUI.rpx(30)),
          child: Row(
            children: [
              Container(
                width: AdaptUI.rpx(150),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: AdaptUI.rpx(30)),
                ),
              ),
              Expanded(
                  child: widget.child
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: AdaptUI.rpx(30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
