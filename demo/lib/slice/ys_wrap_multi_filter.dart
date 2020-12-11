import 'package:adaptui/adaptui.dart';
import 'package:demo/common/common.dart';
import 'package:demo/slice/ys_wrap_filter.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:flutter/material.dart';

typedef Decoration WrapMultiItemDecoration(
    int currentIndex, List<int> indexArr);
typedef void WidgetMultiIndexBlock(List<int> indexArr);

/* 多行 多项 筛选 */
class YsWrapMultiFilterWidget extends StatefulWidget {
  final List list;
  final double iwidth;
  final double iheight;
  final Color textColor;
  final EdgeInsetsGeometry margin;
  final WrapMultiItemDecoration decorationIndexArr;
  final WidgetMultiIndexBlock indexChanged;

  YsWrapMultiFilterWidget(
      {Key key,
      this.list,
      this.iwidth,
      this.iheight,
      this.margin,
      this.textColor,
      this.indexChanged,
      this.decorationIndexArr})
      : super(key: key);

  @override
  _YsWrapMultiFilterWidgetState createState() =>
      _YsWrapMultiFilterWidgetState();
}

class _YsWrapMultiFilterWidgetState extends State<YsWrapMultiFilterWidget>
    with MultiDataLine {
  var selectedArr = [0];

  // 单项点击
  void itemDidTap(int index) {
    if (index == 0) {
      selectedArr = [0];
    } else {
      if (selectedArr.contains(0)) {
        selectedArr.remove(0);
      }
      if (!selectedArr.contains(index)) {
        selectedArr.add(index);
      } else if (selectedArr.length > 1) {
        selectedArr.remove(index);
      }
    }
    widget.indexChanged(selectedArr);
    /* 深拷贝更新数组 */
    getLine<List<int>>("multi").setData([...selectedArr]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list?.asMap()?.keys?.map((index) {
            return GestureDetector(
                onTapUp: (tap) {
                  itemDidTap(index);
                },
                child: getLine<List<int>>("multi", initValue: selectedArr)
                    .addObserver((context, data) => Container(
                          width: widget.iwidth,
                          height: widget.iheight,
                          margin: widget.margin,
                          decoration: widget.decorationIndexArr(index, data),
                          child: Center(
                              child: Text(
                            widget.list[index].toString(),
                            style: TextStyle(
                                fontSize: AdaptUI.rpx(28),
                                color: data.contains(index)
                                    ? Colors.white
                                    : widget.textColor),
                          )),
                        )));
          })?.toList() ??
          [],
    );
  }
}
