import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/data/order_data.dart';
import 'package:demo/model/order_detail_bean.dart';
import 'package:demo/model/order_index_bean.dart';
import 'package:demo/model/order_water_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/cell_row_widget.dart';
import 'package:demo/slice/order_detail_header.dart';
import 'package:demo/slice/order_detail_info.dart';
import 'package:demo/slice/order_detail_water.dart';
import 'package:demo/slice/row_spaceBetween_widget.dart';
import 'package:demo/slice/ys_head_level.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  final String id;

  OrderDetailPage({Key key, @required this.id}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> with MultiDataLine {
  final String key = "detailKey";
  OrderDetailBean _orderBean;
  OrderWaterBean _waterBean;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<bool>(key).onLoading();
    loadOrderInfo();
  }

  void loadOrderInfo() {
    Future.wait([
      XXNetwork.shared
          .post(params: {"methodName": "OrderInfo", "order_id": widget.id}),
      XXNetwork.shared
          .post(params: {"methodName": "OrderWater", "order_id": widget.id})
    ]).then((valueArr) {
      return Future.wait([
        parseOrderDetailCompute(valueArr[0]),
        parseOrderWaterCompute(valueArr[1])
      ]);
    }).then((modelArr) {
      this._orderBean = modelArr[0];
      this._waterBean = modelArr[1];
      getLine<bool>(key).setData(true, true);
    }).catchError((err) {
      getLine<bool>(key).onFailure();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单详情"),
        elevation: 0,
        centerTitle: true,
      ),
      body: getLine<bool>(key)
          .addObserver(builder: (ctx, _, __) => _getPageWidget()),
    );
  }

  Widget _getPageWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        RowSpaceBetweenWidget(
          left: Text("订单编号"),
          right: Text("NO.${_orderBean.infoOrder.orderNo}"),
        ),
        OrderDetailHeaderWidget(orderBean: _orderBean),
        OrderDetailInfoWidget(
          orderBean: _orderBean,
        ),
        OrderDetailWaterWidget(
          waterList: _waterBean.waterList,
        ),
        _protocolWidget()
      ],
    ));
  }


  Widget _protocolWidget() {
    return Container(
      margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
      child: CellRowWidget(
        onTapUp: () => App.navigationToProtocol(context, JJRoleType.nurse),
        children: [
          RichText(text: TextSpan(
              children: [
                TextSpan(text: "查看", style: TextStyle(color: UIColor.hex333)),
                TextSpan(text: "《服务协议》", style: TextStyle(color: UIColor.mainColor))
              ]
          ))
        ],
      ),
    );

  }


  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }
}
