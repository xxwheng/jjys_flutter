import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/model/order_detail_bean.dart';
import 'package:demo/slice/cell_row_widget.dart';
import 'package:flutter/material.dart';


class OrderDetailInfoWidget extends StatelessWidget {

  final OrderDetailBean orderBean;

  OrderDetailInfoWidget({Key key, this.orderBean}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return _orderInfoRows();
  }

  /* 订单信息 */
  Widget yuyingSalaryRow() {
    return Container(
      margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
      child: CellRowWidget(
        onTapUp: () {},
        children: [
          Text("查看工资支付情况"),
          Icon(
            Icons.arrow_forward_ios,
            size: AdaptUI.rpx(30),
            color: UIColor.hex999,
          )
        ],
      ),
    );
  }

  Widget _orderInfoRows() {
    var _orderBean = orderBean;
    List<Widget> listWidget = [];
    if (_orderBean.orderRole != JJRoleType.cuiRu &&
        _orderBean.orderRole != JJRoleType.other) {
      listWidget.add(CellRowWidget(
        children: [
          Text("服务项目"),
          Text(_orderBean.infoOrder.title,
              style: TextStyle(color: UIColor.hex666)),
        ],
      ));
    }
    if (_orderBean.orderRole == JJRoleType.nurse) {
      listWidget.add(CellRowWidget(
        children: [
          Text("预约上门时间"),
          Text(_orderBean.infoOrder.scheduleDate,
              style: TextStyle(color: UIColor.hex666)),
        ],
      ));
    } else if (_orderBean.orderRole == JJRoleType.matron ||
        _orderBean.orderRole == JJRoleType.shortMatron) {
      listWidget.add(CellRowWidget(
        children: [
          Text("预产期"),
          Text(_orderBean.infoOrder.scheduleDate,
              style: TextStyle(color: UIColor.hex666)),
        ],
      ));
    }
    listWidget.addAll([
      CellRowWidget(
        children: [
          Text("服务天数"),
          Text(_orderBean.infoOrder.productDays,
              style: TextStyle(color: UIColor.hex666)),
        ],
      ),
      CellRowWidget(
        children: [
          Text("服务地址"),
          Text(_orderBean.infoOrder.addressInfo,
              style: TextStyle(color: UIColor.hex666)),
        ],
      ),
      CellRowWidget(
        children: [
          Text("联系人"),
          Text(_orderBean.infoOrder.userName,
              style: TextStyle(color: UIColor.hex666)),
        ],
      ),
      CellRowWidget(
        children: [
          Text("联系方式"),
          Text(_orderBean.infoOrder.phone,
              style: TextStyle(color: UIColor.hex666)),
        ],
      ),
      CellRowWidget(
        children: [
          Text("备注:"),
          Text(_orderBean.infoOrder.remark,
              style: TextStyle(color: UIColor.hex666)),
        ],
      )
    ]);

    return Column(
      children: [
        _orderBean.orderRole == JJRoleType.nurse ? yuyingSalaryRow() : Row(),
        Container(
          margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
          child: Column(
            children: listWidget,
          ),
        )
      ],
    )

      ;
  }
}
