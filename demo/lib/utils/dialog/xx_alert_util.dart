
import 'dart:async';

import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/cupertino.dart';

class XXAlertUtil {
  static Future<bool> defaultShow(BuildContext context, String content) {
    Completer<bool> _completer = Completer<bool>();
    showCupertinoDialog(context: context, builder: (ctx) {
      return CupertinoAlertDialog(title: Text("温馨提示"), content: Container(
        child: Text(content),
        padding: EdgeInsets.only(top: AdaptUI.rpx(10)),
      ) ,actions: [
        CupertinoDialogAction(child: Text("取消", style: TextStyle(color: UIColor.hex666)), onPressed: () {
          _completer.complete(false);
          Navigator.of(ctx).pop();
        },),
        CupertinoDialogAction(child: Text("确定", style: TextStyle(color: UIColor.mainColor)), onPressed: (){
          Navigator.of(ctx).pop();
          _completer.complete(true);
        },)
      ],);
    });
    return _completer.future;
  }
}