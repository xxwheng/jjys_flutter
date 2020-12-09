import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef StringCallBack(String msg);

/* 优惠券兑换弹窗 */
class CouponDialog {
  StringCallBack tapCallBack;

  TextEditingController _controller;

  BuildContext _dialogContext;

  CouponDialog() {
    _controller = TextEditingController();
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: _dialogWidget,
    );
  }

  void hide() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext).pop();
    }
  }

  Widget _dialogWidget(BuildContext dialogContext) {
    _dialogContext = dialogContext;
    _controller.text = "";
    return Dialog(
      child: Container(
        height: AdaptUI.rpx(370),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: AdaptUI.rpx(30)),
                  child: Text(
                    "兑换优惠券",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: AdaptUI.rpx(30),
                      left: AdaptUI.rpx(50),
                      right: AdaptUI.rpx(50)),
                  height: AdaptUI.rpx(90),
                  child: CupertinoTextField(
                    controller: _controller,
                    placeholder: "请输入您的兑换码",
                    style: TextStyle(fontSize: AdaptUI.rpx(30)),
                    decoration: BoxDecoration(
                        border: Border.all(color: UIColor.borderMain),
                        borderRadius:
                            BorderRadius.all(Radius.circular(AdaptUI.rpx(10)))),
                  ),
                ),
                GestureDetector(
                  onTap: () => this.tapCallBack(_controller.text),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: AdaptUI.rpx(30),
                        left: AdaptUI.rpx(50),
                        right: AdaptUI.rpx(50)),
                    height: AdaptUI.rpx(90),
                    decoration: BoxDecoration(
                        color: UIColor.borderMain,
                        borderRadius:
                            BorderRadius.all(Radius.circular(AdaptUI.rpx(10)))),
                    child: Center(
                      child: Text(
                        "兑换",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: this.hide,
              child: Container(
                padding: EdgeInsets.only(
                    left: AdaptUI.rpx(20), top: AdaptUI.rpx(20)),
                child: Icon(
                  Icons.close,
                  size: AdaptUI.rpx(50),
                  color: UIColor.hexEEE,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
