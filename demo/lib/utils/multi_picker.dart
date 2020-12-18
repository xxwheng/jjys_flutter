
import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/model/city_bean.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProvincePicker {
  List<CityBean> originData;

  Future initData() {
    return parseLocalCityCompute().then((value) {
      originData = value;
      return this;
    });
  }


  void show(BuildContext context) {
    var picker = MultiPicker(context: context, indexArr: [0,0,0], originData: originData, itemChanged: (list) {
      print("${list[0].cityName}, ${list[1].cityName}, ${list[2].cityName}," );
    });
    picker.initData();
    picker.show();
  }
}

class MultiPicker with MultiDataLine {

  BuildContext context;

  final List<CityBean> originData;


  MultiPicker({@required this.context, this.indexArr, this.originData, this.itemChanged});

  final ValueChanged<List<CityBean>> itemChanged;

  final List<int> indexArr;
  List<List<CityBean>> dataSource;

  List<FixedExtentScrollController> controllerList;

  BuildContext _popContext;

  void initData() {
    controllerList = indexArr.map((e) => FixedExtentScrollController(initialItem: e)).toList();
    dataSource = indexArr.map((e) => List<CityBean>()).toList();
    dataSource[0] = originData;
    if (indexArr.length >= 2) {
      dataSource[1] = originData[0].children;
    }
    if (indexArr.length >= 3) {
      dataSource[2] = originData[indexArr[0]].children[indexArr[1]].children;
    }
  }


  void show() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          _popContext = context;
          return Container(
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Column(
                children: [
                  controlWidget(),
                  Expanded(
                      child: multiPicker()
                  )
                ],
              ));
        });
  }

  void ensureTap() {
    var temp = dataSource.asMap().keys.map((index) => dataSource[index][indexArr[index]]).toList();
    this.itemChanged(temp);
    this.dismiss();
  }

  void dismiss() {
    Navigator.of(_popContext).pop();
  }


  Widget multiPicker() {
    return Row(
      children: List.generate(indexArr.length, (section) {
        return Expanded(
          flex: 1,
        child: getLine<List<CityBean>>("key_$section", initValue: this.dataSource[section]).addObserver(
          builder: (ctx, _, __) {

            return CupertinoPicker(
              scrollController: controllerList[section],
                itemExtent: 40,
                onSelectedItemChanged: (row) {
                  this.indexArr[section] = row;
                  if (section == 0) {
                    changeSection(0);
                  } else if (section == 1) {
                    changeSection(1);
                  }
                },
                children:
                dataSource[section]?.map((e) {
                  return Center(
                    child: Text(e.cityName, style: TextStyle(fontSize: AdaptUI.rpx(28)),),
                  );
                })?.toList() ??
                    []
            );
          }
        ) ,);
      }),
    );
  }

  void changeSection(int section) {
    if (section == 2) return;

    if (section < 1) {
      this.dataSource[1] = this.originData[indexArr[0]].children;
      getLine<List<CityBean>>("key_1").setData(this.dataSource[1]);
      if (indexArr[1] >= dataSource[1].length) {
        indexArr[1] = dataSource[1].length - 1;
        controllerList[1].jumpToItem(indexArr[1]);
        print("第二列超标");
      }
    }

    if (section < 2 && indexArr.length > 2) {
      this.dataSource[2] = this.originData[indexArr[0]].children[indexArr[1]].children;
      getLine<List<CityBean>>("key_2").setData(this.dataSource[2]);
      if (indexArr[2] >= dataSource[2].length) {
        indexArr[2] = dataSource[2].length - 1;
        controllerList[2].jumpToItem(indexArr[2]);
      }
    }
  }

  /// 控制栏
  Widget controlWidget() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border(
              bottom:
              BorderSide(width: 1, color: UIColor.hexEEE))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              width: 70,
              child: Center(
                  child: Text(
                    "取消",
                    style: TextStyle(
                        fontSize: 16,
                        color: UIColor.hex333,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none),
                  )),
            ),
            onTapUp: (tap) => dismiss(),
          ),
          GestureDetector(
            child: Container(
              width: 70,
              child: Center(
                  child: Text("确定",
                      style: TextStyle(
                          fontSize: 16,
                          color: UIColor.mainColor,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none))),
            ),
            onTapUp: (tap) => this.ensureTap(),
          ),
        ],
      ),
    );
  }
}