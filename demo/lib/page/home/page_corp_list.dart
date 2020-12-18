import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/corp_data.dart';
import 'package:demo/data/key_event_bus.dart';
import 'package:demo/model/corp_grop_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/template/a_dart/a_expansion_tile.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* 加盟商列表 */
class PageCorpList extends StatefulWidget {
  @override
  _PageCorpListState createState() => _PageCorpListState();
}

class _PageCorpListState extends State<PageCorpList> with MultiDataLine {

  List<CorpGroupBean> dataSource = [];
  final String key = "cityCorpList";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<int>(key).onLoading();
    loadCorpList();
  }

  // 加载加盟商列表
  void loadCorpList() async {
    XXNetwork.shared.post(params: {"methodName": "CorpGroup"}).then((json) {
      return parseCorpListCompute(json);
    }).then((value) {
      this.dataSource = value;
      getLine<int>(key).setData(DateTime.now().millisecondsSinceEpoch);
    }).catchError((err) {
      getLine<int>(key).onFailure();
    });
  }

  /* 加盟商点击切换 */
  void corpItemDidTap(CorpCityBean bean) {
    logger.i("${bean.titleJiaJia} ${bean.title} ${bean.city}");
    final corpData = Provider.of<CorpData>(context, listen: false);
    corpData.changeCorp(bean);
    App.pop(context);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("加盟商列表"),
        elevation: 0,
        centerTitle: true,
      ),
      body: getLine<int>(key).addObserver(
        onRefresh: loadCorpList,
        builder: (ctx, _, __) {
          return pageListWidget();
        }
      )
    );
  }

  Widget pageListWidget() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: dataSource.length,
        itemBuilder: (context, index) {
          var e = dataSource[index];
          return JJExpansionTile(
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
            ).toList(),
          );
        },
      ),
    );
  }
}
