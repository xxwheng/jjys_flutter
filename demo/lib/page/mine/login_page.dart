import 'package:demo/components/tcaptcha/tc_web_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _hideStage = true;

  /* 点击发送验证码 */
  void _messageSendDidTap() {
    setState(() {
      _hideStage = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(),
                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "手机号",
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child:
                      TextField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "验证码",
                        ),
                      ),),
                      GestureDetector(
                        onTap: this._messageSendDidTap,
                        child: Text("获取验证码"),
                      ),
                    ],
                  )
                ],
              ),
            ),
            TCaptchaWebWidget(
              hideStage: _hideStage,
              successCallback: (ticket, randStr) {
                print(ticket);
              },
              errorCallback: () {

              },
              dismissCallback: () {
                setState(() {
                  _hideStage = true;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
