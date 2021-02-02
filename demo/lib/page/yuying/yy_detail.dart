import 'dart:async';
import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/data/web_url_bridge.dart';
import 'package:demo/model/ys_comment_list.dart';
import 'package:demo/model/ys_detail_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/comment_cell.dart';
import 'package:demo/slice/ys_detail_bottom.dart';
import 'package:demo/slice/ys_detail_cert_chart.dart';
import 'package:demo/slice/ys_detail_header.dart';
import 'package:demo/slice/ys_detail_schedule.dart';
import 'package:demo/slice/ys_detail_score.dart';
import 'package:demo/slice/ys_detail_service.dart';
import 'package:demo/slice/ys_detail_skill.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/data_line.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 育婴师详情详情页
class YYDetailPage extends StatefulWidget {
  final String id;

  YYDetailPage({Key key, this.id}) : super(key: key);

  @override
  _YYDetailPageState createState() => _YYDetailPageState();
}

class _YYDetailPageState extends State<YYDetailPage> with MultiDataLine {
  final String keyInfo = "info";

  /* 工作风采列表*/
  List<String> showList;

  /* 详情 */
  YsDetailBean _ysBean;

  /* 评论列表 */
  YsCommentList _commentList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<YsDetailBean>(keyInfo).onLoading();
    this.onRefresh();
  }

  /// 育婴师详情  工作风采  评论第一页
  void onRefresh() async {
    Future.wait([
      XXNetwork.shared
          .post(params: {"methodName": "SkillerYuyingView", "skiller_id": widget.id}),
      XXNetwork.shared.post(params: {
        "methodName": "YuesaoShowList",
        "skiller_id": widget.id,
        "role": 2,
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
      return Future.wait([
        parseYsDetailCompute(resArr[0]),
        parseYsCommentListCompute(resArr[2])
      ]);
    }).then((value) {
      this._ysBean = value[0];
      this._commentList = value[1];
      getLine<YsDetailBean>(keyInfo).setData(this._ysBean);
    }).catchError((err) {
      getLine<YsDetailBean>(keyInfo).setState(LineState.failure);
    });
  }

  /* 点击工作风采 */
  void _workShowDidTap() {
    App.navigationTo(
        context,
        PageRoutes.ysWorkShowPage +
            "?id=${Uri.encodeComponent(_ysBean.profile.id)}&type=${Uri.encodeComponent(JJRoleType.matron.index.toString())}");
  }

  /* 点击月嫂认证信息 */
  void _gotoAuthInfoWebPage() async {
    String url =
    await WebUrlBridge.urlBridget(kAuthInfoYueSao + _ysBean.profile.id);
    App.navigationTo(
      context,
      PageRoutes.singleWebPage +
          "?title=${Uri.encodeComponent(_ysBean.profile.nickname)}&url=${Uri.encodeComponent(url)}",
    );
  }

  /* 点击服务内容 */
  void _gotoServiceInfo() async {
    String url = await WebUrlBridge.urlBridget(
        kYueSaoServiceInfo + _ysBean.profile.level);
    App.navigationTo(
      context,
      PageRoutes.singleWebPage +
          "?title=${Uri.encodeComponent(_ysBean.profile.nickname)}&url=${Uri.encodeComponent(url)}",
    );
  }

  void _gotoYsCommitOrder() {
    App.navigationTo(context, PageRoutes.ysOrderCommitPage+"?id=${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("育婴师详情"),
        elevation: 0,
        centerTitle: true,
      ),
      body: getLine<YsDetailBean>(keyInfo).addObserver(
        onRefresh: onRefresh,
        builder: (context, data, _) {
          logger.i("构建build");
          return Stack(
            children: [
              Positioned(
                child: pageListView(),
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: YsDetailBottomWidget(
                  id: _ysBean.profile.id,
                  type: JJRoleType.matron,
                  isCollect: _ysBean.isCollect == 1,
                  onChat: ()=>App.navigationToChatLink(context),
                  onMake: _gotoYsCommitOrder,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget pageListView() {
    return ListView.builder(
      itemCount: _commentList.data.length + 4,
      itemBuilder: (ctx, index) {
        if (index == 0) {
          return Column(
            children: [
              ysDetailHeader(),
              ysDetailSkillSection(),
              ysChartWidget(),
              workShowList(),
              YsDetailScheduleWidget(),
            ],
          );
        } else if (index == 1) {
          return serviceContent();
        } else if (index == 2) {
          return YsDetailScoreWidget(
            commentNum: _commentList.data.length,
            avg: _commentList.score.scoreAvg,
            scoreList: _commentList.score.ysScoreList,
          );
        } else if (index == _commentList.data.length + 3) {
          return Container(height: AdaptUI.rpx(140),);
        } else {
          var e = _commentList.data[index - 3];
          return YsCommentCell(
            headIcon: e.headPhoto,
            name: e.username,
            service: "服务${e.productDays}天",
            score: e.score,
            time: e.timeStr,
            desc: e.detail,
            pics: e.image,
          );
        }
      },
    );
  }

  /// 月嫂头部信息
  Widget ysDetailHeader() {
    return YsDetailHeader(
      nickName: _ysBean.profile.nickname,
      headPhoto: _ysBean.profile.image,
      levelText: YsLevel.getYuesaoLevel(_ysBean.profile.level),
      isCredit: _ysBean.profile.credit == "1",
      provinceAgeText:
      "${_ysBean.profile.provinceText} ${_ysBean.profile.age}岁",
      price: "￥${_ysBean.profile.price}",
      service: "/${_ysBean.profile.service}天",
    );
  }

  /// 月嫂技能信息
  Widget ysDetailSkillSection() {
    return YsDetailSkillWidget(
      score: _ysBean.profile.commentScore,
      experience: _ysBean.credit.experience,
      services: _ysBean.credit.services,
      duration: _ysBean.credit.duration,
      authInfoRowTap: this._gotoAuthInfoWebPage,
    );
  }

  /// 月嫂能力值图表
  Widget ysChartWidget() {
    return YsDetailCertChartWidget(
      certTitles: _ysBean.credit.certificate.map((e) => e.title).toList(),
      introduce: _ysBean.profile.introduce,
      label: _ysBean.profile.label,
      charts: _ysBean.credit.charts,
    );
  }

  ///* 服务内容 */
  Widget serviceContent() {
    return YsDetailServiceWidget(
      type: JJRoleType.matron,
      onMoreTap: _gotoServiceInfo,
    );
  }

  /// 工作风采
  Widget workShowList() {
    return showList.length > 0
        ? Container(
      margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
      padding: EdgeInsets.all(AdaptUI.rpx(30)),
      color: Colors.white,
      child: Column(
        children: [
          Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: showList
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
    )
        : Row();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }
}
