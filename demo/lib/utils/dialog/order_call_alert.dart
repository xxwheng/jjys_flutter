import 'package:demo/common/color.dart';
import 'package:demo/data/config_data.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/utils/helper_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



/* 订单拨打电话 */
class OrderCallAlert {
  static show(BuildContext context, String tel) {
    var mobile = tel ?? "";
    if (mobile.isEmpty) {
      mobile = ConfigData.shared.configCorpBean?.contact ?? "";
      if (mobile.isEmpty) {
        mobile = "400-080-8850";
      }
    }

    showCupertinoDialog(context: context, builder: (ctx) {
      return CupertinoAlertDialog(
        title: Text("拨打电话"),
        content: Text(mobile),
        actions: [
          CupertinoDialogAction(child: Text("取消", style: TextStyle(color: UIColor.hex666)), onPressed: ()=>App.pop(ctx),),
          CupertinoDialogAction(child: Text("确定", style: TextStyle(color: UIColor.mainColor)), onPressed: (){
            App.pop(ctx);
            HelperTool.makeCall(mobile);
          },)
        ],
      );
    });
  }
}

