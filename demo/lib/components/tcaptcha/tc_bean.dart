import 'dart:convert';

/* 腾讯防水墙 验证 回调 模型 */
class TCVerifyBean {
  String appid;
  String randstr;
  int ret;
  String ticket;

  TCVerifyBean(this.appid, this.randstr, this.ret, this.ticket);

  factory TCVerifyBean.fromMessage(String message) {
    Map<String, dynamic> json = jsonDecode(message);
    return TCVerifyBean(json["appid"].toString(), json["randstr"].toString(), int.parse(json["ret"].toString()), json["ticket"].toString());
  }
}

/* 腾讯防水墙 加载成功回调 窗口大小 */
class TCSDKView {
  double width;
  double height;

  TCSDKView(this.width, this.height);

  factory TCSDKView.fromMessage(String message) {
    Map<String, dynamic> json = jsonDecode(message)["sdkView"];
    return TCSDKView(json["width"] as double, json["height"] as double);
  }
}