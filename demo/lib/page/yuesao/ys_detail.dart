import 'dart:async';
import 'dart:convert';

import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/components/empty/empty.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/data/web_url_bridge.dart';
import 'package:demo/model/ys_detail_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/page/root/base_page_interface.dart';
import 'package:demo/slice/ys_chart.dart';
import 'package:demo/slice/ys_detail_cert_chart.dart';
import 'package:demo/slice/ys_detail_header.dart';
import 'package:demo/slice/ys_detail_schedule.dart';
import 'package:demo/slice/ys_detail_score.dart';
import 'package:demo/slice/ys_detail_service.dart';
import 'package:demo/slice/ys_detail_skill.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class YsDetailPage extends StatefulWidget {
  final String id;

  YsDetailPage({Key key, this.id}) : super(key: key);

  @override
  _YsDetailPageState createState() => _YsDetailPageState();
}

YsDetailBean jsonCompute(param) {
  return YsDetailBean.fromJson(param);
}

class _YsDetailPageState extends State<YsDetailPage> with MultiDataLine {
  YsDetailBean _ysBean;

  final String keyInfo = "info";
  final String keyShow = "showList";

  /* 工作风采列表*/
  List<String> showList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<YsDetailBean>(keyInfo).onLoading();
    this.onRefresh();
  }

  /// 月嫂详情  工作风采  评论第一页
  void onRefresh() async {
    Future.wait([
      XXNetwork.shared
          .post(params: {"methodName": "YuesaoView", "yuesao_id": widget.id}),
      XXNetwork.shared.post(params: {
        "methodName": "YuesaoShowList",
        "yuesao_id": widget.id,
        "page": 1,
        "size": 5
      }),
      XXNetwork.shared.post(params: {
        "methodName": "YuesaoCommentList",
        "yuesao_id": widget.id,
        "page": 1,
        "size": 10,
        "role": 1,
      })
    ]).then((resArr) {
      List<String> showList = (resArr[1]['data'] as List)
          ?.map((e) => null == e ? null : e['url'].toString())
          ?.toList();
      if (showList.length > 3) {
        showList = showList.sublist(0, 3);
      }
      this.showList = showList;
      getLine<List<String>>(keyShow).setData(this.showList);
      return ysDetailCompute(resArr[0]);
    }).then((value) {
      this._ysBean = value;
      getLine<YsDetailBean>(keyInfo).setData(this._ysBean);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }

  /* 月嫂详情 */
  Future<bool> loadYsDetailInfo() async {
    return XXNetwork.shared.post(params: {
      "methodName": "YuesaoView",
      "yuesao_id": widget.id
    }).then((value) {
//      this._ysBean = YsDetailBean.fromJson(value);
      logger.i("详情完成");
      return ysDetailParse(value);
    }).then((_) {
      return true;
    }).catchError((err) => false);
  }

  void ysDetailParse(dynamic res) async {
    this._ysBean = await compute(ysDetailCompute, res);
    logger.i("解析完成");
  }

  /* 评论 */
  void loadCommentList() async {
    XXNetwork.shared.post(params: {
      "methodName": "YuesaoCommentList",
      "yuesao_id": widget.id,
      "page": 1,
      "size": 10,
      "role": 1,
    }).then((value) {});
  }

  /* 点击查看认证信息 */
  void authInfoArrowLineTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("月嫂详情"),
          elevation: 0,
          centerTitle: true,
        ),
        body: getLine<YsDetailBean>(keyInfo).addObserver(
            child: workShowList(),
            builder: (context, data, _workShow) {
              logger.i("构建build");
              return Container(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        YsDetailHeader(
                          nickName: _ysBean.profile.nickname,
                          headPhoto: _ysBean.profile.image,
                          levelText:
                              YsLevel.getYuesaoLevel(_ysBean.profile.level),
                          isCredit: _ysBean.profile.credit == "1",
                          provinceAgeText:
                              "${_ysBean.profile.provinceText} ${_ysBean.profile.age}岁",
                          price: "￥${_ysBean.profile.price}",
                          service: "/${_ysBean.profile.service}天",
                        ),
                        YsDetailSkillWidget(
                          score: _ysBean.profile.commentScore,
                          experience: _ysBean.credit.experience,
                          services: _ysBean.credit.services,
                          duration: _ysBean.credit.duration,
                          authInfoRowTap: this._gotoAuthInfoWebPage,
                        ),
                        YsDetailCertChartWidget(
                          certTitles: _ysBean.credit.certificate
                              .map((e) => e.title)
                              .toList(),
                          introduce: _ysBean.profile.introduce,
                          label: _ysBean.profile.label,
                          charts: _ysBean.credit.charts,
                        ),
                      ],
                    ),
                    _workShow,
                    Column(
                      children: [
                        YsDetailScheduleWidget(),
                        YsDetailServiceWidget(
                          type: JJRoleType.matron,
                          onMoreTap: () {},
                        ),
                        YsDetailScoreWidget()
                      ],
                    ),
                  ],
                ),
              );
            },
            onRefresh: onRefresh));
  }

  /* 点击工作风采 */
  void _workShowDidTap() {
    App.navigationTo(context, PageRoutes.ysWorkShowPage+"?id=${Uri.encodeComponent(_ysBean.profile.id)}&type=${Uri.encodeComponent(JJRoleType.matron.index.toString())}");
  }

  /* 月嫂认证信息 */
  void _gotoAuthInfoWebPage() async {
    String url = await WebUrlBridge.urlBridget(kAuthInfoYueSao+_ysBean.profile.id);
    App.navigationTo(context, PageRoutes.singleWebPage+"?title=${Uri.encodeComponent(_ysBean.profile.nickname)}&url=${Uri.encodeComponent(url)}",);
  }

  /// 工作风采
  Widget workShowList() {
    print("工作风采");
    return getLine<List<String>>(keyShow).addObserver(
        child: Column(
          children: [
            GestureDetector(
              onTap: this._workShowDidTap,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "工作风采",
                      style: TextStyle(fontSize: AdaptUI.rpx(32)),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: AdaptUI.rpx(30),
                    color: UIColor.hex999,
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ),
        builder: (ctx, data, child) {
          logger.i("三张图片");
          return Container(
            margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
            padding: EdgeInsets.all(AdaptUI.rpx(30)),
            color: Colors.white,
            child: Column(
              children: [
                child,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: data
                      .map(
                        (e) => CachedNetworkImage(
                          imageUrl: e,
                          width: AdaptUI.rpx(218),
                          height: AdaptUI.rpx(218),
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          );
        });
  }
}
