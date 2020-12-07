import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/user_data.dart';
import 'package:demo/model/user_info_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserInfo();
  }

  /// 个人信息 更新头像，昵称，预产期
  void loadUserInfo() async {
    XXNetwork.shared.post(params: {"methodName": "UserInfo"}).then((value) {
      String headPhoto = value["headphoto"] as String;
      String nick = value["nickname"] as String;
      int preDay = int.parse(value["predict_day"].toString());
      UserData.shared.changeUser(nick: nick, headPhoto: headPhoto, preDay: preDay);
    });
  }

  /* 点击选择头像 */
  void _chooseImage() {
    logger.i("chooseImage");
  }

  /* 修改昵称*/
  void _changeNickName() {
    App.navigationTo(context, PageRoutes.myInfoNickNamePage);
  }

  /* 修改预产期*/
  void _changeBirthday() {}

  /* 退出登录 */
  void _quitButtonDidTap() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CupertinoAlertDialog(
              title: Text("确定要退出登录吗?"),
              actions: [
                CupertinoDialogAction(
                  child: Text("取消"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoDialogAction(
                  child: Text("确定"),
                  onPressed: () {
                    logger.i("确定");
                    UserData.shared.logout();
                    Navigator.of(context).pop();
                    App.pop(this.context);
                  },
                )
              ],
            ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("个人信息"),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: AdaptUI.rpx(150),
                  height: AdaptUI.rpx(150),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AdaptUI.rpx(75))),
                    border: Border.all(color: UIColor.mainColor),
                  ),
                  child: ClipOval(
                    child: Consumer<UserData>(builder:
                        (BuildContext context, UserData userData, child) {
                      return CachedNetworkImage(
                        imageUrl: userData.user.headPhoto,
                        placeholder: (context, url) =>
                            Image.asset("images/place_head.png"),
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: _chooseImage,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("修改头像", style: TextStyle(color: UIColor.hex666)),
                          Icon(
                            Icons.navigate_next,
                            color: UIColor.hex999,
                            size: AdaptUI.rpx(40),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: _changeNickName,
            child: Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
              height: AdaptUI.rpx(110),
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: UIColor.hexEEE),
                  bottom: BorderSide(color: UIColor.hexEEE),
                ),
              ),
              child: Row(
                children: [
                  Text("修改昵称"),
                  Expanded(
                    child: Consumer<UserData>(
                      builder: (context, userData, child) => Text(
                        userData.user.nickName,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: UIColor.hex666),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    size: AdaptUI.rpx(40),
                    color: UIColor.hex999,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _changeNickName,
            child: Container(
              height: AdaptUI.rpx(110),
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: UIColor.hexEEE)),
              ),
              child: Row(
                children: [
                  Text("宝妈预产期/宝宝生日"),
                  Expanded(
                      child: Text("2020-07-16",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: UIColor.hex666))),
                  Icon(
                    Icons.navigate_next,
                    size: AdaptUI.rpx(40),
                    color: UIColor.hex999,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: _quitButtonDidTap,
            child: Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
              height: AdaptUI.rpx(110),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(color: UIColor.hexEEE),
                    bottom: BorderSide(color: UIColor.hexEEE)),
              ),
              child: Center(
                child: Text(
                  "退出登录",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
