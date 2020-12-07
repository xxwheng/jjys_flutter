import 'package:adaptui/adaptui.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/user_data.dart';
import 'package:demo/model/user_info_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/utils/v_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MyInfoNickNamePage extends StatefulWidget {

  @override
  _MyInfoNickNamePageState createState() => _MyInfoNickNamePageState();
}

class _MyInfoNickNamePageState extends State<MyInfoNickNamePage> {

  TextEditingController _controller;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* 输入框获取焦点 */
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (null == _controller) {
        logger.i("监听");
        UserInfoBean user = Provider.of<UserData>(context).user;
        _controller = TextEditingController(text: user.nickName);
        /* 光标移到最后 */
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: user.nickName.length));
    }
  }

  /* 保存昵称 */
  void _nickSaveTap() {
    _focusNode.unfocus();
    XXNetwork.shared.post(params: {
      "methodName": "UserInfoUpdate",
      "nickname": _controller.text
    }).then((value) {
      UserData.shared.changeUser(nick: _controller.text);
      VToast.showThen("修改成功").then((v) => App.pop(context));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("修改昵称"),
        actions: [GestureDetector(
          onTap: _nickSaveTap,
          child: Container(
            width: 60,
            child: Center(child: Text("保存")) ,
          ) ,
        )],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 15, right: 15),
        height: AdaptUI.rpx(110),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: CupertinoTextField(
          focusNode: _focusNode,
          controller: _controller,
          placeholder: "请填写您的昵称",
          clearButtonMode: OverlayVisibilityMode.editing,
          decoration: null,
          onEditingComplete: _nickSaveTap,
        ),
      ),
    );
  }
}
