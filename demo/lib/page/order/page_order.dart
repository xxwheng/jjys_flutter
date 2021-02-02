import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/corp_data.dart';
import 'package:demo/data/key_event_bus.dart';
import 'package:demo/data/order_data.dart';
import 'package:demo/model/order_index_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/order_index_server_info_widget.dart';
import 'package:demo/slice/row_spaceBetween_widget.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/data_line.dart';
import 'package:demo/utils/bus/event_bus.dart';
import 'package:demo/utils/dialog/order_call_alert.dart';
import 'package:demo/utils/dialog/xx_alert_util.dart';
import 'package:flutter/cupertino.dart';
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
    
    eventBus.on(EventBusKey.orderListRefresh, (arg) {
      this.onRefresh();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    eventBus.off(EventBusKey.orderListRefresh);
    dataBusDispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    logger.i(context.widget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    logger.i("deactivate");
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

  /* 拨打客服电话 */
  void keFuDidCall(OrderIndexBean item) {
    OrderCallAlert.show(context, item.infoOrder.contact);
  }

  /* 订单控制按钮点击响应 */
  void orderControlAction(OrderBtsType type, OrderIndexBean item) {
    print(type);
    switch (type) {
      case OrderBtsType.cancel:
        XXAlertUtil.defaultShow(context, "确认取消该订单?").then((value) {
          if (value) {
            this.cancelOrderAction(item.infoOrder.id);
          }
        });
        break;
      case OrderBtsType.payNormal:
        App.navigationTo(context, PageRoutes.ysOrderPayPage + "?id=" + item.infoOrder.id);
        break;
      case OrderBtsType.allPay:
        App.navigationTo(context, PageRoutes.ysOrderPayPage + "?id=" + item.infoOrder.id + "&type=" + OrderPayType.allPay.index.toString());
        break;
      case OrderBtsType.tailPay:
        break;
      case OrderBtsType.payNurseOrder:
        break;
      case OrderBtsType.payNurseSalary:
        break;
      default:
        break;
    }
  }

  /* 取消订单请求 */
  void cancelOrderAction(String id) {
    XXNetwork.shared.post(params: {
      "methodName": "OrderPayCancel",
      "order_id": id
    }).then((value) {
      this.onRefresh();
    });
  }

  /* 跳转订单详情*/
  void gotoOrderDetail(OrderIndexBean bean) {
    App.navigationTo(context, PageRoutes.orderDetailPage + "?id=" + bean.infoOrder.id);
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
            return GestureDetector(
              onTapUp: (_) => this.gotoOrderDetail(item),
              child: Container(
                margin: EdgeInsets.only(bottom: AdaptUI.rpx(30)),
                color: Colors.white,
                child: Column(
                  children: [
                    _orderHeader(item.infoOrder),
                    _serverInfoWidget(item),
                    _controlWidget(item)
                  ],
                ),
              ),
            ) ;
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
      right: Row(
        children: item.ctrlBts.map((e) {
          return GestureDetector(
            child: Container(
              height: AdaptUI.rpx(60),
              decoration: BoxDecoration(
                  border: Border.all(color: e.border, width: 0.7),
                  borderRadius: BorderRadius.all(Radius.circular(100))
              ),
              margin: EdgeInsets.only(left: AdaptUI.rpx(20)),
              padding: EdgeInsets.only(left: AdaptUI.rpx(25), right: AdaptUI.rpx(25)),
              child: Center(child: Text(e.title, style: TextStyle(fontSize: AdaptUI.rpx(28), color: e.color)),) ,
            ),
            onTap: () => this.orderControlAction(e.type, item),
          ) ;
        }).toList(),
      ),
    );
  }

  /* 服务信息 月嫂 金额 预产期 */
  Widget _serverInfoWidget(OrderIndexBean item) {
    return OrderIndexServerInfoWidget(
      item: item,
      keFuCall: () => this.keFuDidCall(item),
    );
  }

  /* 头部 状态 订单编号 */
  Widget _orderHeader(InfoOrder item) {
    return Column(
      children: [
        RowSpaceBetweenWidget(
          left: Text(item.title),
          right: Text(
            OrderDataTool.getStatusText(item.process),
            style: TextStyle(color: UIColor.fontLevel),
          ),
        ),
        RowSpaceBetweenWidget(
          left: Text("订单编号"),
          right: Text(item.orderNo),
        )
      ],
    );
  }
}
