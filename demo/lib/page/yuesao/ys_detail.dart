import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/model/ys_detail_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/ys_chart.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/material.dart';

class YsDetailPage extends StatefulWidget {
  @override
  _YsDetailPageState createState() => _YsDetailPageState();
}

class _YsDetailPageState extends State<YsDetailPage> {
  YsDetailBean _ysBean;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadYsDetailInfo();
  }

  void loadYsDetailInfo() async {
    XXNetwork.shared.post(
        params: {"methodName": "YuesaoView", "yuesao_id": "87"}).then((value) {
      YsDetailBean ysBean = YsDetailBean.fromJson(value);
      _ysBean = ysBean;
      setState(() {});
      print("setState");
    });
  }

  /* 点击查看认证信息 */
  void authInfoArrowLineTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("月嫂详情"),
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: [
            ysDetailHeaderWidget(),
            this.rowBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "雇主评分",
                    style: TextStyle(
                        color: UIColor.hex333,
                        fontSize: AdaptUI.rpx(32),
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    child: Row(
                      children: [
                        ...List.generate(
                            _ysBean?.profile?.commentScore ?? 0,
                            (index) => Container(
                                  margin: EdgeInsets.only(left: 2),
                                  width: AdaptUI.rpx(26),
                                  height: AdaptUI.rpx(26),
                                  child: Image.asset(
                                    "images/ys_heart.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                )),
                        Container(
                          padding: EdgeInsets.only(left: AdaptUI.rpx(10)),
                          child:
                              Text("${_ysBean?.profile?.commentScore ?? 0}分"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            this.rowBottomBorder(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  this.ysExperienceRowWidget(
                      "护理经验 ", "${_ysBean?.credit?.experience ?? 0}年"),
                  this.ysExperienceRowWidget(
                      "服务家庭数 ", "${_ysBean?.credit?.services ?? 0}个"),
                  this.ysExperienceRowWidget(
                      "培训课时 ", "${_ysBean?.credit?.duration ?? 0}个"),
                ],
              ),
            ),
            GestureDetector(
              onTap: this.authInfoArrowLineTap,
              child: this.rowBottomBorder(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "认证信息",
                      style: TextStyle(
                          color: UIColor.hex333,
                          fontSize: AdaptUI.rpx(32),
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: UIColor.hex999,
                      size: AdaptUI.rpx(40),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: AdaptUI.rpx(30),
                  bottom: AdaptUI.rpx(30),
                  top: AdaptUI.rpx(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: AdaptUI.rpx(20),
                    runSpacing: AdaptUI.rpx(20),
                    children: [
                      ..._ysBean?.credit?.certificate
                              ?.map(
                                (e) => Container(
                                  padding: EdgeInsets.only(
                                      left: AdaptUI.rpx(30),
                                      top: AdaptUI.rpx(10),
                                      bottom: AdaptUI.rpx(10),
                                      right: AdaptUI.rpx(30)),
                                  decoration: BoxDecoration(
                                      color: UIColor.mainColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(AdaptUI.rpx(30)))),
                                  child: Text(
                                    e.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AdaptUI.rpx(26)),
                                  ),
                                ),
                              )
                              ?.toList() ??
                          [],
                    ],
                  ),
                  Container(
                    height: AdaptUI.rpx(30),
                  ),
                  Text(
                    _ysBean?.profile?.introduce ?? "",
                    style: TextStyle(
                        color: UIColor.hex666, fontSize: AdaptUI.rpx(28)),
                  ),
                  Container(
                    height: AdaptUI.rpx(30),
                  ),
                  Wrap(
                    children: _ysBean?.profile?.label
                            ?.map((e) => Container(
                                  padding: EdgeInsets.only(
                                      left: AdaptUI.rpx(15),
                                      right: AdaptUI.rpx(15),
                                      top: AdaptUI.rpx(5),
                                      bottom: AdaptUI.rpx(5)),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: UIColor.hex999),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text(
                                    e,
                                    style: TextStyle(color: UIColor.mainColor),
                                  ),
                                ))
                            ?.toList() ??
                        [],
                  ),
                  _ysBean == null
                      ? Offstage()
                      : YsChartWidget(
                          values: _ysBean.credit.charts
                              .map((e) => int.parse(e) / 100.0)
                              .toList(),
                        )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
              padding: EdgeInsets.all(AdaptUI.rpx(30)),
              height: AdaptUI.rpx(360),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "工作排期",
                          style: TextStyle(
                              fontSize: AdaptUI.rpx(32), color: UIColor.hex333),
                        ),
                      ),
                      Text(
                        "最近一年",
                        style: TextStyle(
                            fontSize: AdaptUI.rpx(30), color: UIColor.hex666),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: AdaptUI.rpx(30),
                        color: UIColor.hex999,
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: AdaptUI.rpx(10), bottom: AdaptUI.rpx(10)),
                    height: AdaptUI.rpx(180),
                    child: PageView(
                      controller: PageController(),
                      children: [
                        Container(
                          color: Colors.blue,
                          child: Center(
                            child: Text("blur"),
                          ),
                        ),
                        Container(
                          color: Colors.green,
                          child: Center(
                            child: Text("blur"),
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          child: Center(
                            child: Text("blur"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: AdaptUI.rpx(20),
                        height: AdaptUI.rpx(20),
                        color: UIColor.hex999,
                        margin: EdgeInsets.only(right: AdaptUI.rpx(10)),
                      ),
                      Text("可预约"),
                      Container(
                        width: AdaptUI.rpx(20),
                        height: AdaptUI.rpx(20),
                        color: Color(0xffc398e3),
                        margin: EdgeInsets.only(
                            left: AdaptUI.rpx(60), right: AdaptUI.rpx(10)),
                      ),
                      Text("已占用")
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
              padding: EdgeInsets.all(AdaptUI.rpx(30)),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "服务内容",
                          style: TextStyle(
                              fontSize: AdaptUI.rpx(32), color: UIColor.hex333),
                        ),
                      ),
                      Text(
                        "查看更多",
                        style: TextStyle(
                            fontSize: AdaptUI.rpx(30), color: UIColor.hex666),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: AdaptUI.rpx(30),
                        color: UIColor.hex999,
                      )
                    ],
                  ),
                  Container(
                    height: AdaptUI.rpx(20),
                  ),
                  Wrap(
                    spacing: AdaptUI.rpx(14),
                    runSpacing: AdaptUI.rpx(20),
                    children: ["基本护理", "科学喂养", "宝宝早教", "产后恢复", "月子餐", "母婴护理"]
                        .map((e) {
                      return Container(
                        width: AdaptUI.rpx(220),
                        height: AdaptUI.rpx(240),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: AdaptUI.rpx(10)),
                              width: AdaptUI.rpx(220),
                              height: AdaptUI.rpx(180),
                              color: Colors.red,
                            ),
                            Text(
                              e,
                              style: TextStyle(
                                  fontSize: AdaptUI.rpx(30),
                                  color: UIColor.hex666),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
              padding: EdgeInsets.all(AdaptUI.rpx(30)),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("用户评价(10)", style: TextStyle(fontSize: AdaptUI.rpx(30)),)),
                      heartLineWidget("综合评分", 5, MainAxisAlignment.end)
                    ],
                  ),
                  Container(height: AdaptUI.rpx(30),),
                  Wrap(
                    spacing: AdaptUI.rpx(30),
                    runSpacing: AdaptUI.rpx(20),
                    children: ["宝宝护理", "宝宝早教", "膳食搭配", "科学素养", "产妇护理", "沟通技巧"]
                        .map((e) => heartLineWidget(e, 5))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /* 评分widget title+heart+score */
  Widget heartLineWidget(String title, int score, [MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start]) {
    return
      Container(
      width: AdaptUI.rpx(330),
      child:
      Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Container(
            margin: EdgeInsets.only(right: AdaptUI.rpx(10)),
            child: Text(title),
          ),
          Row(
            children: List.generate(
                score,
                (index) => Container(
                  margin: EdgeInsets.only(left:AdaptUI.rpx(5)),
                  child: Image.asset(
                    "images/ys_heart.png",
                    width: AdaptUI.rpx(20),
                    height: AdaptUI.rpx(20),
                  ),
                ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: AdaptUI.rpx(10)),
            child: Text("$score分"),
          )

        ],
      ),
    );
  }

  /* 底部有下划线的横向栏 */
  Widget rowBottomBorder({Widget child}) {
    return Container(
      padding: EdgeInsets.only(left: AdaptUI.rpx(30), right: AdaptUI.rpx(30)),
      height: AdaptUI.rpx(90),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: UIColor.hexEEE)),
      ),
      child: child,
    );
  }

  /* 护理经验 单个 */
  Widget ysExperienceRowWidget(String title, String content) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: TextStyle(color: UIColor.hex333, fontSize: AdaptUI.rpx(30))),
      TextSpan(
          text: content,
          style: TextStyle(color: UIColor.mainColor, fontSize: AdaptUI.rpx(30)))
    ]));
  }

  /* 头部视图 */
  Widget ysDetailHeaderWidget() {
    return Container(
      height: AdaptUI.rpx(470),
      child: _ysBean == null
          ? Offstage()
          : Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: _ysBean?.profile?.image ?? "",
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: AdaptUI.rpx(30), bottom: AdaptUI.rpx(50)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: AdaptUI.rpx(20)),
                        child: Text(
                          _ysBean?.profile?.nickname,
                          style: TextStyle(
                              fontSize: AdaptUI.rpx(46),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: AdaptUI.rpx(20)),
                        child: Text(
                          YsLevel.getYuesaoLevel(_ysBean?.profile?.level),
                          style: TextStyle(
                              fontSize: AdaptUI.rpx(30),
                              color: UIColor.levelYellow),
                        ),
                      ),
                      _ysBean.profile.credit == "1"
                          ? Container(
                              padding: EdgeInsets.only(bottom: AdaptUI.rpx(20)),
                              child: YsAuthWidget(),
                            )
                          : Offstage(),
                      Container(
                        padding: EdgeInsets.only(bottom: AdaptUI.rpx(20)),
                        child: Text(
                          "${_ysBean.profile.provinceText} ${_ysBean.profile.age}岁",
                          style: TextStyle(fontSize: AdaptUI.rpx(32)),
                        ),
                      ),
                      Container(
                        height: AdaptUI.rpx(10),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "￥${_ysBean.profile.price}",
                            style: TextStyle(
                                fontSize: AdaptUI.rpx(38),
                                fontWeight: FontWeight.bold,
                                color: UIColor.fontLevel)),
                        TextSpan(
                            text: "/${_ysBean.profile.service}天",
                            style: TextStyle(
                                fontSize: AdaptUI.rpx(28),
                                color: UIColor.hex666))
                      ]))
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
