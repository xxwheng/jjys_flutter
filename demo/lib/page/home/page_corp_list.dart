import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/model/corp_grop_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/template/a_dart/a_expansion_tile.dart';
import 'package:flutter/material.dart';

/* 加盟商列表 */
class PageCorpList extends StatefulWidget {
  @override
  _PageCorpListState createState() => _PageCorpListState();
}

class _PageCorpListState extends State<PageCorpList> {
  List<CorpGroupBean> dataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCorpList();
  }

  // 加载加盟商列表
  void loadCorpList() async {
    XXNetwork.shared.post(params: {"methodName": "CorpGroup"}).then((value) {
      List<CorpGroupBean> list = (value['corp_group'] as List)
          ?.map((e) => e == null ? null : CorpGroupBean.fromJson(e))
          ?.toList();
      setState(() {
        this.dataSource = list;
      });
    });
  }

  /* 加盟商点击切换 */
  void corpItemDidTap(CorpCityBean bean) {
    logger.i("${bean.titleJiaJia} ${bean.title} ${bean.city}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("加盟商列表"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: dataSource
              .map((e) => JJExpansionTile(
                    trailing: Offstage(),
                    title: Text(
                      e.city,
                      style: TextStyle(fontSize: AdaptUI.rpx(30)),
                    ),
                    children: e.list
                        .asMap()
                        .keys
                        .map(
                          (index) => GestureDetector(
                            onTap: () => this.corpItemDidTap(e.list[index]),
                            child: FractionallySizedBox(
                            widthFactor: 1,
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: AdaptUI.rpx(20),
                                    bottom: AdaptUI.rpx(20)),
                                margin: EdgeInsets.only(left: AdaptUI.rpx(20)),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: index == 0
                                                ? Colors.white
                                                : UIColor.hexEEE))),
                                child: Text(
                                  "${e.list[index].titleJiaJia}",
                                  style: TextStyle(
                                      fontSize: AdaptUI.rpx(28),
                                      color: UIColor.hex333),
                                )),
                          ),
                          ),
                        )
                        .toList(),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
