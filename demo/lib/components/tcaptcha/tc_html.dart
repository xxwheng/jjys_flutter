class TCaptchaHtmlString {
  String random;

  String get htmlString => _getHtmlStr();

  TCaptchaHtmlString();

  factory TCaptchaHtmlString.loading() {
    TCaptchaHtmlString _tc = TCaptchaHtmlString();
    // 8位随机数
    _tc.resetRandom();
    return _tc;
  }

  void resetRandom() {
    this.random = "6c54af43";
  }

  String _getHtmlStr() {
    return """
<!DOCTYPE html>
<html lang="en">
<head>
    <script  src="https://ssl.captcha.qq.com/TCaptcha.js?v=$random" type="text/javascript"></script>
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
</head>
<body>
<script type="text/javascript">
    (function () {
        window.SDKTCaptchaVerifyCallback = function (retJson) {
            if (retJson){
                /// 原生回调 Flutter取参数 是String类型， 所以要转成字符串
                verifiedAction.postMessage(JSON.stringify(retJson))
            }
        };

        // 验证码加载完成的回调，用来设置webview尺寸
        window.SDKTCaptchaReadyCallback = function (retJson) {
            if (retJson && retJson.sdkView && retJson.sdkView.width && retJson.sdkView.height &&  parseInt(retJson.sdkView.width) >0 && parseInt(retJson.sdkView.height) >0 ){
                loadAction.postMessage(JSON.stringify(retJson))
            }
        };

        window.onerror = function (msg, url, line, col, error) {
            if (window.TencentCaptcha == null) {
                errorAction.postMessage(JSON.stringify(error))
            }
        };

        var sdkOptions = {"sdkOpts": {"width": 265, "height": 265}};
        sdkOptions.ready = window.SDKTCaptchaReadyCallback;
        window.onload = function () {
            //此处需要替换xxxxxx为appid
            new TencentCaptcha("2036965850", SDKTCaptchaVerifyCallback, sdkOptions).show();
        };
    })();
</script>
</body>
</html>
""";
  }
}
