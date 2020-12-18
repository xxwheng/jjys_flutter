import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/material.dart';

typedef NavMenuTapCallback = void Function(String listOrder, String forceDesc);

class FilterNavWidget extends StatefulWidget {

  final NavMenuTapCallback onChanged;
  final VoidCallback showFilter;

  FilterNavWidget({Key key, this.onChanged, this.showFilter}): super(key: key);

  @override
  _FilterNavWidgetState createState() => _FilterNavWidgetState();
}

class _FilterNavWidgetState extends State<FilterNavWidget> {

  final List<Map<String, String>> navArray = [
    {"title": "综合", "desc": "1"},
    {"title": "价格", "desc": "1"},
    {"title": "评价", "desc": "1"},
    {"title": "筛选", "desc": "1"},
  ];
  int navIndex = 0;

  /* 导航按钮点击 */
  void navItemDidTap(int index) {
    /// 最后一个 弹出筛选框
    if (index == this.navArray.length - 1) {
      widget.showFilter();
      return;
    }
    /// 点击当前选中的， 改变列表顺序
    if (this.navIndex == index) {
      if (index > 0) {
        this.navArray[index]["desc"] =
        this.navArray[index]["desc"] == "1" ? "0" : "1";
        setState(() {});
        widget.onChanged((index+1).toString(), this.navArray[index]["desc"]);
      }
      return;
    }

    this.navIndex = index;
    setState(() {});
    widget.onChanged((index+1).toString(), this.navArray[index]["desc"]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
      height: AdaptUI.rpx(120),
      width: AdaptUI.screenWidth,
      child: Row(
          children: navArray.asMap().keys.map((index) {
            return Expanded(
              child: InkWell(
                child: Container(
                  height: AdaptUI.rpx(120),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        navArray[index]["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AdaptUI.rpx(32),
                            color: navIndex == index
                                ? UIColor.mainColor
                                : UIColor.hex333),
                      ),
                      afterIcon(index),
                    ],
                  ),
                ),
                onTap: () => this.navItemDidTap(index),
              ),
            );
          }).toList()),
    )],
    ) ;
  }

  /// 菜单栏 icon
  Widget afterIcon(int index) {
    if (index == 0) {
      return Icon(
        Icons.keyboard_arrow_down,
        size: AdaptUI.rpx(28),
        color: navIndex == 0 ? UIColor.mainColor : UIColor.hex666,
      );
    } else if (index < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.keyboard_arrow_up,
            size: AdaptUI.rpx(28),
            color: navIndex == index && navArray[index]['desc'] == '0'
                ? UIColor.mainColor
                : UIColor.hex666,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: AdaptUI.rpx(28),
            color: navIndex == index && navArray[index]['desc'] == '1'
                ? UIColor.mainColor
                : UIColor.hex666,
          )
        ],
      );
    } else {
      return Icon(Icons.filter_alt_outlined, size: AdaptUI.rpx(28));
    }
  }
}
