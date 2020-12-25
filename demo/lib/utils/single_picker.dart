import 'package:demo/common/color.dart';
import 'package:demo/data/global_define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/* 单列选择器 */
class SinglePicker {
  factory SinglePicker(BuildContext context, List<String> list,
      TDStringIntCallBack onChanged,
          {int startIndex = 0}) =>
      SinglePicker._internal(context, list, onChanged, startIndex: startIndex);

  SinglePicker._internal(
      BuildContext context, List<String> list, TDStringIntCallBack onChanged,
      {int startIndex}) {
    _context = context;
    _list = list;
    _onChanged = onChanged;
    if (startIndex > 0 && startIndex < _list.length) {
      _index = startIndex;
    }
  }

  FixedExtentScrollController _controller;

  BuildContext _context;

  BuildContext _pickerContext;

  TDStringIntCallBack _onChanged;

  List<String> _list;

  int _index = 0;

  void show() {
    if (_index >= _list.length) {
      _index = 0;
    }
    if (_index > 0) {
      _controller = FixedExtentScrollController(initialItem: _index);
    } else {
      _controller = FixedExtentScrollController();
    }

    showCupertinoModalPopup(
      context: _context,
      builder: (context) {
        _pickerContext = context;
        return Container(
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: UIColor.hexEEE))),
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
                        onTapUp: _pop,
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
                        onTapUp: _ensureTap,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: CupertinoPicker(
                        scrollController: _controller,
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          _index = index;
                        },
                        children: _list?.map((title) {
                          return Center(
                            child: Text(title),
                          );
                        })?.toList() ??
                            []))
              ],
            ));
      },
    );
  }

  void _ensureTap(tap) {
    if (_list != null && _list.isNotEmpty) {
      _onChanged(_list[_index], _index);
    }
    _pop(tap);
  }

  void _pop(_) {
    Navigator.of(_pickerContext).pop();
  }

}
