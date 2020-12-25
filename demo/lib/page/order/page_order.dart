import 'dart:math';

import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/components/empty/error_page.dart';
import 'package:demo/components/empty/loading_page.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/corp_data.dart';
import 'package:demo/data/order_data.dart';
import 'package:demo/model/order_index_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/order_index_server_info_widget.dart';
import 'package:demo/slice/row_spaceBetween_widget.dart';
import 'package:demo/slice/ys_detail_header.dart';
import 'package:demo/slice/ys_head_level.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/data_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 订单-tab
class PageOrder extends StatefulWidget {
  @override
  _PageOrderState createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder>
    with MultiDataLine, PageDataSource<OrderIndexBean> {
  final String key = "order_index";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<bool>(key).onLoading();
    onRefresh();
  }

  @override
  void loadPageData() {
    XXNetwork.shared.post(params: {
      "methodName": "OrderIndex",
      "page": this.page,
      "size": this.size
    }).then((value) {
      return parseOrderListCompute(value);
    }).then((orderList) {
      addList(orderList.data, orderList.page, orderList.total);
      getLine<bool>(key).setData(true, true);
    }).catchError((err) {
      logger.i(err);
      this.endRefreshing(status: false);
      if (list.isEmpty) {
        getLine<bool>(key).setState(LineState.failure);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CorpData>(
            builder: (context, corp, _) => Text(corp.corpBean.titleJiaJia)),
        centerTitle: true,
        elevation: 0,
      ),
      body: getLine<bool>(key).addObserver(builder: (ctx, _, __) {
        return _orderListView();
      }),
    );
  }

  /* 订单列表 */
  Widget _orderListView() {
    return PageRefreshWidget(
      pageDataSource: this,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx, index) {
            var item = list[index];
            return Container(
              margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
              color: Colors.white,
              child: Column(
                children: [
                  _orderHeader(item.infoOrder),
                  _serverInfoWidget(item),
                  _controlWidget(item)
                ],
              ),
            );
          }),
    );
  }

  /* 控制栏 */
  Widget _controlWidget(OrderIndexBean item) {
    return RowSpaceBetweenWidget(
      left: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "已付: ",
              style:
                  TextStyle(fontSize: AdaptUI.rpx(30), color: UIColor.hex333)),
          TextSpan(
              text: "￥" + item.infoOrder.payMoney,
              style: TextStyle(
                  fontSize: AdaptUI.rpx(30), color: UIColor.fontLevel))
        ]),
      ),
      right: Row(),
    );
  }

  /* 服务信息 月嫂 金额 预产期 */
  Widget _serverInfoWidget(OrderIndexBean item) {
    return OrderIndexServerInfoWidget(item: item);
  }

  /* 头部 状态 订单编号 */
  Widget _orderHeader(InfoOrder item) {
    return Column(
      children: [
        RowSpaceBetweenWidget(
          left: Text(item.title),
          right: Text(OrderDataTool.getStatusText(item.process)),
        ),
        RowSpaceBetweenWidget(
          left: Text("订单编号"),
          right: Text(item.orderNo),
        )
      ],
    );
  }
}
