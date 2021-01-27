import 'dart:math';

import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/corp_data.dart';
import 'package:demo/data/user_data.dart';
import 'package:demo/model/user_info_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/mine/login_page.dart';
import 'package:demo/page/root/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 我的-tab
class PageMine extends StatefulWidget {
  @override
  _PageMineState createState() => _PageMineState();
}

class _PageMineState extends State<PageMine> with WidgetsBindingObserver, NavigatorObserver {
  final List<String> menuList = ["我的优惠券", "我的关注", "分享应用", "专属服务", "关于"];
  final List<Widget> leadIcons = [
    Icon(Icons.flag, color: UIColor.hex666),
    Icon(Icons.star, color: UIColor.hex666),
    Icon(Icons.share, color: UIColor.hex666),
    Icon(Icons.call, color: UIColor.hex666),
    Icon(Icons.privacy_tip_outlined, color: UIColor.hex666)
  ];

  @override
  void initState() {
    // TODO: implement initState
    logger.i("mine_initState");
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    logger.i("mine_didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
    logger.i("mine_didPushRoute");
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
    logger.i("mine_didPopRoute");
    return super.didPopRoute();
  }

  @override
  void didUpdateWidget(covariant PageMine oldWidget) {
    // TODO: implement didUpdateWidget
    logger.i("mine_didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    logger.i("mine_deactivate");
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    logger.i("mine_AppLife_${state.toString()}");
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /* 点击头像 */
  void headerIconDidTap() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));
    return;
    if (!UserData.isLogin) {
      App.navigationTo(context, PageRoutes.loginPage);
      return;
    }
    App.navigationTo(context, PageRoutes.myInfoPage);
  }

  /// 点击
  void itemDidTapIndex(int index) {
    if (!UserData.isLogin) {
      App.navigationTo(context, PageRoutes.loginPage);
      return;
    }

    switch (index) {
      case 0:
        App.navigationTo(context, PageRoutes.myCouponPage);
        break;
      case 1:
        App.navigationTo(context, PageRoutes.myCollect);
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    logger.i("mine_build");
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CorpData>(
            builder: (context, corp, _) => Text(corp.corpBean.titleJiaJia)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              color: UIColor.mainColor,
              padding: EdgeInsets.only(
                  top: AdaptUI.rpx(60), bottom: AdaptUI.rpx(50)),
              child: GestureDetector(
                onTap: this.headerIconDidTap,
                child: Column(
                  children: [
                    ClipOval(
                      child: Consumer<UserData>(
                        builder: (context, userData, _) => userData.user != null
                            ? CachedNetworkImage(
                                imageUrl: userData.user.headPhoto,
                                placeholder: (context, url) =>
                                    Image.asset("images/place_head.png"),
                                fit: BoxFit.cover,
                                width: AdaptUI.rpx(180),
                                height: AdaptUI.rpx(180),
                              )
                            : Image.asset(
                                "images/place_head.png",
                                width: AdaptUI.rpx(180),
                                height: AdaptUI.rpx(180),
                              ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: AdaptUI.rpx(40)),
                      child: Center(
                        child:
                            Consumer<UserData>(builder: (context, userData, _) {
                          return Text(
                            userData?.user?.nickName ?? "未登录",
                            style: TextStyle(
                              fontSize: AdaptUI.rpx(34),
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
            ),
            ...menuList
                .asMap()
                .keys
                .map((index) => Container(
                      padding: EdgeInsets.only(
                          left: AdaptUI.rpx(30), right: AdaptUI.rpx(25)),
                      height: AdaptUI.rpx(90),
                      child: GestureDetector(
                        onTapUp: (tap) => this.itemDidTapIndex(index),
                        child: Row(
                          children: [
                            leadIcons[index],
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(left: AdaptUI.rpx(10)),
                              child: Text(
                                menuList[index],
                                style: TextStyle(
                                    fontSize: AdaptUI.rpx(30),
                                    color: UIColor.hex333),
                              ),
                            )),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: AdaptUI.rpx(30),
                              color: UIColor.hex999,
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
