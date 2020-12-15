import 'package:adaptui/adaptui.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:flutter/material.dart';

/* 多行 单项 筛选 */
typedef Decoration WrapItemDecoration(int currentIndex, int selectedIndex);
typedef void WidgetIndexBlock(int index);

class YsWrapFilterWidget extends StatefulWidget {
  final List list;
  final double iwidth;
  final double iheight;
  final Color textColor;
  final EdgeInsetsGeometry margin;
  final WrapItemDecoration decoration;
  final WidgetIndexBlock itemChanged;


  YsWrapFilterWidget({Key key, this.list, this.iwidth, this.iheight, this.margin, this.textColor, this.itemChanged, this.decoration})
      : super(key: key);

  @override
  _YsWrapFilterWidgetState createState() => _YsWrapFilterWidgetState();
}

class _YsWrapFilterWidgetState extends State<YsWrapFilterWidget> with MultiDataLine {

  final String keyIndex = "keyIndex";

  // 单项点击
  void itemDidTap(int index) {
    getLine<int>(keyIndex).setData(index);
    widget.itemChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list?.asMap()?.keys?.map((index) {
        return GestureDetector(
            onTapUp: (tap) {
              itemDidTap(index);
            },
            child: getLine<int>(keyIndex, initValue: 0).addObserver(builder: (context, data, _) => Container(
              width: widget.iwidth,
              height: widget.iheight,
              margin: widget.margin,
              decoration: widget.decoration(index, data),
              child: Center(child: Text(widget.list[index].toString(), style: TextStyle(fontSize: AdaptUI.rpx(28), color: index == data ? Colors.white : widget.textColor),)),
            ))
        );
      })?.toList() ?? [],
    );
  }
}
