import 'package:adaptui/adaptui.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/model/user_collect_bean.dart';
import 'package:demo/model/ys_item_bean.dart';
import 'package:demo/model/ys_list_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/template/yuesao/cell_yuesao.dart';
import 'package:demo/utils/v_toast.dart';
import 'package:flutter/material.dart';

class CollectYsTabView extends StatefulWidget {

  ///  角色类型
  final JJRoleType type;

  CollectYsTabView({Key key, @required this.type}): super(key: key);

  @override
  _CollectYsTabViewState createState() => _CollectYsTabViewState();
}

class _CollectYsTabViewState extends State<CollectYsTabView>
    with PageDataSource<UserCollectBean>, AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
  }

  @override
  void loadPageData() {
    // TODO: implement loadPageData
    super.loadPageData();
    XXNetwork.shared.post(params: {
      "methodName": "YuesaoCollectList",
      "page": this.page,
      "size": this.size,
      "role": widget.type,
    }).then((res) {
      var collectList = (res['data'] as List)
          ?.map((e) => e == null ? null : UserCollectBean.fromJson(e))
          ?.toList();
      var page = int.parse(res['page'].toString());
      var total = int.parse(res['total'].toString());
      addList(collectList, page, total, setState);
    }).catchError((err) {
      this.endRefreshing(status: false);
    }).whenComplete(() {});
  }

  /* 点击进详情 */
  void _gotoDetails(UserCollectBean bean) {
    if (bean.type == "1") {
      App.navigationTo(context, PageRoutes.ysDetailPage+'?id=${bean.info.id}');
    } else {
    }
  }

  /* 请求取消 */
  void _reqCancel(UserCollectBean bean) {
    XXNetwork.shared.post(params: {
      "methodName": "YuesaoCollectCancel",
      "yuesao_id": bean.info.id,
      "role": bean.type
    }).then((value) {
      VToast.show("取消成功");
      setState(() {
        list.remove(bean);
      });
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return PageRefreshWidget(
      pageDataSource: this,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
        UserCollectYsInfoBean item = list[index].info;
        return Container(
          padding: EdgeInsets.only(left: AdaptUI.rpx(30)),
          margin: EdgeInsets.only(
              left: AdaptUI.rpx(30),
              top: AdaptUI.rpx(20),
              right: AdaptUI.rpx(30),
              bottom: AdaptUI.rpx(0)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AdaptUI.rpx(10))),
          child: GestureDetector(
            child: CellYuesao(
              type: widget.type,
              headPhoto: item.icon,
              isCredit: item.isCredit == 1,
              level: item.level,
              careType: item.careType,
              nickName: item.name,
              desc: item.recommend,
              score: "${item.scoreComment}",
              price: item.price,
              service: item.service,
              cancelTap: () => _reqCancel(list[index]),
            ),
            onTapUp: (TapUpDetails detail) => _gotoDetails(list[index]),
          ),
        );
      }),
    );
  }
}
