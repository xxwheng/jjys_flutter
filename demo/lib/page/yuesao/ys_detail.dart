import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/model/ys_detail_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/ys_chart.dart';
import 'package:demo/slice/ys_detail_cert_chart.dart';
import 'package:demo/slice/ys_detail_header.dart';
import 'package:demo/slice/ys_detail_schedule.dart';
import 'package:demo/slice/ys_detail_score.dart';
import 'package:demo/slice/ys_detail_service.dart';
import 'package:demo/slice/ys_detail_skill.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/material.dart';

class YsDetailPage extends StatefulWidget {

  final String id;

  YsDetailPage({Key key, this.id}): super(key: key);

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

  /* 月嫂详情 */
  void loadYsDetailInfo() async {
    XXNetwork.shared.post(
        params: {"methodName": "YuesaoView", "yuesao_id": widget.id}).then((value) {
      YsDetailBean ysBean = YsDetailBean.fromJson(value);
      logger.i(ysBean.profile.nickname);
      _ysBean = ysBean;
      setState(() {});
    });
  }

  void loadCommentList() async {
    XXNetwork.shared.post(params: {
      "methodName":"YuesaoCommentList",
      "yuesao_id": widget.id,
      "page": 1,
      "size": 10,
      "role": 1,
    }).then((value) {

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
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            ysDetailHeaderWidget(),
            YsDetailSkillWidget(
              score: _ysBean?.profile?.commentScore ?? 0,
              experience: _ysBean?.credit?.experience,
              services: _ysBean?.credit?.services,
              duration: _ysBean?.credit?.duration,
            ),
            YsDetailCertChartWidget(
              certTitles: _ysBean?.credit?.certificate?.map((e) => e.title)?.toList(),
              introduce: _ysBean?.profile?.introduce,
              label: _ysBean?.profile?.label,
              charts: _ysBean?.credit?.charts,
            ),
            YsDetailScheduleWidget(),
            YsDetailServiceWidget(),
            YsDetailScoreWidget()
          ],
        ),
      ),
    );
  }


  /* 头部视图 */
  Widget ysDetailHeaderWidget() {
    return _ysBean==null?Offstage():YsDetailHeader(
      nickName: _ysBean?.profile?.nickname ?? "",
      headPhoto: _ysBean?.profile?.image ?? "",
      levelText: YsLevel.getYuesaoLevel(_ysBean?.profile?.level),
      isCredit: _ysBean.profile.credit == "1",
      provinceAgeText: "${_ysBean.profile.provinceText} ${_ysBean.profile.age}岁",
      price: "￥${_ysBean.profile.price}",
      service: "/${_ysBean.profile.service}天",
    );
  }
}
