import 'package:adaptui/adaptui.dart';
import 'package:demo/data/global_define.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:flutter/material.dart';

/* 单选列表 */
class RadioListView extends StatefulWidget {
  final int beginIndex;
  final List<Widget> children;
  final TDIntCallBack indexCallBack;

  RadioListView({Key key, @required this.children, this.indexCallBack, this.beginIndex}) : super(key: key);

  @override
  _RadioListViewState createState() => _RadioListViewState();
}

class _RadioListViewState extends State<RadioListView> with MultiDataLine {
  int _selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.children.isNotEmpty) {
      _selectedIndex = widget.beginIndex ?? 0;
      this.doCallBack();
    }
  }

  void _radioOnTap(int index) {
    if (index == _selectedIndex) return;
    getLine<bool>("radio_$index").setData(true);
    getLine<bool>("radio_$_selectedIndex").setData(false);
    _selectedIndex = index;
    this.doCallBack();
  }

  void doCallBack() {
    if (widget.indexCallBack != null) {
      widget.indexCallBack(_selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.children.asMap().keys.map((index) {
        return GestureDetector(
          onTap: () => _radioOnTap(index),
          child:
              getLine<bool>("radio_$index", initValue: _selectedIndex == index)
                  .addObserver(
                      child: widget.children[index],
                      builder: (ctx, isSelected, child) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: AdaptUI.rpx(30)),
                          child: Row(
                            children: [
                              Image.asset(
                                isSelected
                                    ? "images/ic_circle_sel.png"
                                    : "images/ic_circle.png",
                                width: AdaptUI.rpx(36),
                                height: AdaptUI.rpx(36),
                              ),
                              Expanded(child: child)
                            ],
                          ),
                        );
                      }),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }
}
