import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/components/tcaptcha/tc_bean.dart';
import 'package:demo/components/tcaptcha/tc_html.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

/* 腾讯防水墙 验证回调 */
typedef TCaptchaCallback(String ticket, String randStr);

class TCaptchaWebWidget extends StatefulWidget {
  final TCaptchaCallback successCallback;

  final VoidCallback errorCallback;

  final VoidCallback dismissCallback;

  final bool hideStage;

  TCaptchaWebWidget({Key key, this.hideStage, this.successCallback, this.errorCallback, this.dismissCallback})
      : super(key: key);

  @override
  _TCaptchaWebWidgetState createState() => _TCaptchaWebWidgetState();
}

class _TCaptchaWebWidgetState extends State<TCaptchaWebWidget> {

  TCSDKView sizeView;

  final TCaptchaHtmlString _tc = TCaptchaHtmlString.loading();

  WebViewPlusController controller;

  @override
  void dispose() {
    // TODO: implement dispose
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    if (widget.hideStage == false) {
      print("显示");
      _tc.resetRandom();
      if (null != controller) {
        controller.loadString(_tc.htmlString);
      }
    }

    return Offstage(
      offstage: widget.hideStage,
      child: Stack(
        children: [
          Opacity(opacity: 0.1,child:
            Container(
              color: Color(0x19000000),
            )
            ,),
          Align(
            alignment: Alignment(0, -0.3),
            child: Container(
              width: 260,
              height: 260,
              child: WebViewPlus(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewPlusController controller) {
                  this.controller = controller;
                  controller.loadString(_tc.htmlString);
                },
                javascriptChannels: [
                  JavascriptChannel(
                    name: "loadAction",
                    onMessageReceived: (JavascriptMessage message) {
                      TCSDKView sdkView = TCSDKView.fromMessage(message.message);

                      print("width: ${sdkView.width} height: ${sdkView.height}");

                      setState(() {
                        this.sizeView = sdkView;
                      });
                    },
                  ),
                  JavascriptChannel(
                    name: "verifiedAction",
                    onMessageReceived: (JavascriptMessage message) {
                      TCVerifyBean bean = TCVerifyBean.fromMessage(message.message);
                      if (bean.ret == 0) {// 成功
                        widget.successCallback(bean.ticket, bean.randstr);
                        widget.dismissCallback();
                      } else if (bean.ret == 2) {// 关闭
                        widget.dismissCallback();
                      }
                    },
                  ),
                  JavascriptChannel(
                    name: "errorAction",
                    onMessageReceived: (JavascriptMessage message) {
                      widget.errorCallback();
                      widget.dismissCallback();
                    },
                  ),
                  //加载失败
                ].toSet(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
