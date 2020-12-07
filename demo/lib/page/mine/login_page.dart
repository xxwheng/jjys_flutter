import 'dart:async';

import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/components/tcaptcha/tc_web_widget.dart';
import 'package:demo/data/user_data.dart';
import 'package:demo/data/web_url_bridge.dart';
import 'package:demo/model/user_info_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/utils/verify_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hideStage = true;

  String msgTitle = "获取验证码";

  /* 验证码按钮是否禁止响应 */
  bool _msgBtAbsorb = false;

  TextEditingController _phoneController;
  TextEditingController _codeController;

  /* 验证码发送校验 */
  List<ToastRow> _msgSendJudgeList() {
    return [
      ToastRow(_phoneController.text.isNotEmpty, "请输入手机号码"),
      ToastRow(_phoneController.text.length == 11, "请输入11位手机号码")
    ];
  }

  /* 登录提交校验 */
  List<ToastRow> _loginJudgeList() {
    return [ToastRow(_phoneController.text.isNotEmpty, "请输入手机号码"),
      ToastRow(_phoneController.text.length == 11, "请输入11位手机号码"),
      ToastRow(_codeController.text.isNotEmpty, "请输入验证码")];
  }

  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController = TextEditingController();
    _codeController = TextEditingController();
  }

  /* 验证、隐藏 防水墙 */
  void _tcaptchaIsShow(bool isShow) {
    _hideStage = !isShow;
    setState(() {});
  }

  /* 验证码按钮是否可以点击 */
  void _msgButtonCanTap(bool isCan) {
    setState(() {
      _msgBtAbsorb = !isCan;
    });
  }

  /* 点击发送验证码 -> 腾讯防水墙 -> 验证码请求 -> 倒计时 */
  void _showTcaptchaDidTap() {
    if (!ToastUtil.judgeList(_msgSendJudgeList())) {
      return;
    }
    _tcaptchaIsShow(true);
  }

  /* 发送验证码请求 */
  void _messageSendReq(String ticket, String randStr) {
    _msgButtonCanTap(false);
    _startTimer();
    XXNetwork.shared.post(params: {
      "mobile": _phoneController.text,
      "ticket": ticket,
      "randstr": randStr,
      "sign": ""
    }).then((value) {
      _startTimer();
    }).catchError((e) {
      _msgButtonCanTap(true);
    });
  }

  /* 开始倒计时 */
  void _startTimer() {
    final Duration duration = Duration(seconds: 1);
    _cancelTimer();
    int number = 60;
    _timer = Timer.periodic(duration, (timer) {
      if (number == 0) {
        _timer.cancel();
        msgTitle = "重新获取";
        _msgButtonCanTap(true);
      } else {
        number--;
        msgTitle = "重新获取${number}s";
      }
      setState(() {});
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  /* 点击提交登录 */
  void _submitDidTap() {
    if (!ToastUtil.judgeList(_loginJudgeList())) {
      return;
    }

    XXNetwork.shared.post(params: {
      "methodName": "SmsCheckUser",
      "mobile": _phoneController.text,
      "code": _codeController.text,
    }).then((value) {
      UserInfoBean user = UserInfoBean.fromJson(value);
      UserData.shared.loginSuccess(user);
      App.pop(context);
    });
  }

  /* 点击查看协议 */
  void _gotoProtocolWebPage() async {
    String url = await WebUrlBridge.urlBridget(kUrlRegisterProtocol);
    App.navigationTo(context, PageRoutes.singleWebPage+"?title=${Uri.encodeComponent('注册协议')}&url=${Uri.encodeComponent(url)}",);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        elevation: 0,
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: AdaptUI.rpx(40)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
                      height: AdaptUI.rpx(88),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: UIColor.hexEEE))),
                      child: Row(
                        children: [
                          Container(
                            width: AdaptUI.rpx(140),
                            child: Text(
                              "手机号码",
                              style: TextStyle(fontSize: AdaptUI.rpx(30)),
                            ),
                          ),
                          Expanded(
                            child: CupertinoTextField(
                              controller: _phoneController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11)
                              ],
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: AdaptUI.rpx(30)),
                              placeholder: "请输入手机号码",
                              decoration: null,
                              clearButtonMode: OverlayVisibilityMode.editing,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
                      height: AdaptUI.rpx(88),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: UIColor.hexEEE))),
                      child: Row(
                        children: [
                          Container(
                            width: AdaptUI.rpx(140),
                            child: Text(
                              "验证码",
                              style: TextStyle(fontSize: AdaptUI.rpx(30)),
                            ),
                          ),
                          Expanded(
                            child: CupertinoTextField(
                              controller: _codeController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: AdaptUI.rpx(30)),
                              placeholder: "请输入验证码",
                              decoration: null,
                            ),
                          ),
                          AbsorbPointer(
                            absorbing: _msgBtAbsorb,
                            child: InkWell(
                              onTap: this._showTcaptchaDidTap,
                              child: Container(
                                margin: EdgeInsets.only(left: AdaptUI.rpx(20)),
                                padding: EdgeInsets.only(
                                    top: AdaptUI.rpx(8),
                                    bottom: AdaptUI.rpx(8),
                                    left: AdaptUI.rpx(15),
                                    right: AdaptUI.rpx(15)),
                                decoration: BoxDecoration(
                                  color: UIColor.mainColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(AdaptUI.rpx(100))),
                                ),
                                child: Text(
                                  msgTitle,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AdaptUI.rpx(26)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _gotoProtocolWebPage,
                      child: Container(
                        padding: EdgeInsets.only(top: AdaptUI.rpx(30)),
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "点击提交,代表同意",
                                    style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(28))
                                ),
                                TextSpan(
                                  text: "家家月嫂平台注册协议",
                                  style: TextStyle(color: UIColor.mainColor, fontSize: AdaptUI.rpx(28)),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: this._submitDidTap,
                      child: Container(
                        margin: EdgeInsets.only(top: AdaptUI.rpx(40)),
                        width: AdaptUI.screenWidth - AdaptUI.rpx(60),
                        height: AdaptUI.rpx(80),
                        decoration: BoxDecoration(
                            color: UIColor.mainColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(AdaptUI.rpx(10)))),
                        child: Center(
                          child: Text(
                            "提交",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: AdaptUI.rpx(32), color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              TCaptchaWebWidget(
                hideStage: _hideStage,
                successCallback: this._messageSendReq,
                errorCallback: () {
                  _tcaptchaIsShow(false);
                  Fluttertoast.showToast(msg: "加载异常,请稍后重试");
                },
                dismissCallback: () => _tcaptchaIsShow(false),
              )
            ],
          ),
        ),
      ),
    );
  }
}
