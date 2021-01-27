import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/model/order_detail_bean.dart';
import 'package:demo/slice/cell_row_widget.dart';
import 'package:demo/slice/row_spaceBetween_widget.dart';
import 'package:demo/slice/ys_head_level.dart';
import 'package:demo/slice/ys_name_auth.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/material.dart';

/* 订单详情头部 */
class OrderDetailHeaderWidget extends StatelessWidget {
  final OrderDetailBean orderBean;

  OrderDetailHeaderWidget({Key key, @required this.orderBean})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _serverCaregiverItem(),
        Column(
          children: _priceListWidget(),
        )
      ],
    );
  }

  List<Widget> _priceListWidget() {
    var _orderBean = orderBean;
    List<Widget> list = [];
    if (_orderBean.orderRole == JJRoleType.nurse) {
      list = [
        CellRowWidget(
          children: [
            Text("平台服务费"),
            Text(
              _orderBean.yuServicePriceBean.status,
              style: TextStyle(color: UIColor.hex666),
            ),
            Text(
              "￥${_orderBean.yuServicePriceBean.moneyToPay}",
              style: TextStyle(color: UIColor.hex666),
            )
          ],
        ),
        RowSpaceBetweenWidget(
          left: Text("优惠金额"),
          right: Text("￥${_orderBean.infoOrder.couponMomey}",
              style: TextStyle(color: UIColor.hex666)),
        ),
        CellRowWidget(
          children: [
            Text("工资押金"),
            Text(
              _orderBean.yuCashPledgeBean.status,
              style: TextStyle(color: UIColor.hex666),
            ),
            Text("￥${_orderBean.yuCashPledgeBean.moneyToPay}",
                style: TextStyle(color: UIColor.hex666)),
          ],
        ),
        CellRowWidget(
          children: [
            Text("家政服务保险"),
            Text(
              _orderBean.yuInsuranceBean.status,
              style: TextStyle(color: UIColor.hex666),
            ),
            Text("￥${_orderBean.yuInsuranceBean.moneyToPay}",
                style: TextStyle(color: UIColor.hex666)),
          ],
        ),
        RowSpaceBetweenWidget(
          left: Text("已支付"),
          right: Text("￥${_orderBean.infoOrder.payMoney}",
              style: TextStyle(color: UIColor.hex666)),
        ),
        RowSpaceBetweenWidget(
          left: Text("待支付", style: TextStyle(color: UIColor.fontLevel)),
          right: Text("￥${_orderBean.infoOrder.waitPay}",
              style: TextStyle(color: UIColor.fontLevel)),
        ),
      ];
    } else {
      list = [
        RowSpaceBetweenWidget(
          left: Text("服务价格"),
          right: Text("￥${_orderBean.infoOrder.productPrice}"),
        ),
        RowSpaceBetweenWidget(
          left: Text("优惠金额"),
          right: Text("-￥${_orderBean.infoOrder.couponMomey}"),
        ),
        RowSpaceBetweenWidget(
          left: Text("已支付"),
          right: Text("￥${_orderBean.infoOrder.payMoney}"),
        ),
        RowSpaceBetweenWidget(
          left: Text("待支付"),
          right: Text("￥${_orderBean.infoOrder.waitPay}"),
        )
      ];
    }
    if (_orderBean.chargeExtra != null) {
      for (var i = 0; i < _orderBean.chargeExtra.data.length; i++) {}
    }
    return list;
  }

  /// 服务技师
  Widget _serverCaregiverItem() {
    var _orderBean = orderBean;
    switch (_orderBean.orderRole) {
      case JJRoleType.matron:
      case JJRoleType.nurse:
        return Column(
            children: _orderBean.caregiverServer.map((e) {
          return Stack(
            children: [
              _headerHoleContainer([
                YuesaoHeadLevelWidget(
                  headUrl: e.infoCaregiver.icon,
                  level: e.infoCaregiver.level,
                  type: _orderBean.orderRole,
                  careType: e.infoCaregiver.careType,
                ),
                _headerInfoContainer([
                  YuesaoNameAuthWidget(
                    nickname: e.infoCaregiver.name,
                    isCredit: e.infoCaregiver.isCredit == '1',
                    style: TextStyle(
                        fontSize: AdaptUI.rpx(36), fontWeight: FontWeight.w500),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: AdaptUI.rpx(30)),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "服务天数: ",
                            style: TextStyle(
                                fontSize: AdaptUI.rpx(28),
                                color: UIColor.hex333)),
                        TextSpan(
                            text: e.serviceDay,
                            style: TextStyle(
                                fontSize: AdaptUI.rpx(36), color: Colors.black))
                      ]),
                    ),
                  ),
                ])
              ])
            ],
          );
        }).toList());
      case JJRoleType.cuiRu:
        return Stack(
          children: [
            _headerHoleContainer([
              YuesaoHeadLevelWidget(
                headUrl: icCuiRu,
                level: _orderBean.infoCaregiver.level,
                type: _orderBean.orderRole,
                careType: _orderBean.infoCaregiver.careType,
              ),
              _headerInfoContainer([
                Text("服务级别: ${YsLevel.getCuiRuType(_orderBean.infoOrder.num)}"),
                Text("预约时间: ${_orderBean.infoOrder.scheduleDate}"),
                Text(
                  "已付:    ￥${_orderBean.infoOrder.payMoney}",
                  style: TextStyle(color: UIColor.fontLevel),
                )
              ])
            ])
          ],
        );
      case JJRoleType.shortMatron:
        return Stack(
          children: [
            _headerHoleContainer([
              YuesaoHeadLevelWidget(
                headUrl: _orderBean.infoCaregiver?.icon,
                level: _orderBean.infoCaregiver?.level,
                type: _orderBean.orderRole,
                careType: _orderBean.infoCaregiver?.careType,
              ),
              _headerInfoContainer([
                Text(
                  _orderBean.infoOrder.title ?? '',
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(36), fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.only(top: AdaptUI.rpx(5)),
                  child: Text(
                    "服务人员:  待指定",
                    style: TextStyle(fontSize: AdaptUI.rpx(30)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: AdaptUI.rpx(5), bottom: AdaptUI.rpx(10)),
                  child: Text(
                    "服务天数: ${_orderBean.infoOrder.productDays}",
                    style: TextStyle(fontSize: AdaptUI.rpx(30)),
                  ),
                )
              ])
            ])
          ],
        );
      case JJRoleType.other:
        return Stack(
          children: [
            _headerHoleContainer([
              YuesaoHeadLevelWidget(
                headUrl: _orderBean.infoCaregiver.icon,
                level: _orderBean.infoCaregiver.level,
                type: _orderBean.orderRole,
                careType: _orderBean.infoCaregiver.careType,
              ),
              _headerInfoContainer([
                Text(
                  _orderBean.infoOrder.title,
                  style: TextStyle(
                      fontSize: AdaptUI.rpx(36), fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.only(top: AdaptUI.rpx(5)),
                  child: Text(
                    "套餐类型: ${_orderBean.infoOrder.attribute ?? ''}",
                    style: TextStyle(fontSize: AdaptUI.rpx(30)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: AdaptUI.rpx(5)),
                  child: Text(
                    "预约时间: ${_orderBean.infoOrder.scheduleDate}",
                    style: TextStyle(fontSize: AdaptUI.rpx(30)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: AdaptUI.rpx(5), bottom: AdaptUI.rpx(10)),
                  child: Text(
                    "未付: ￥${_orderBean.infoOrder.totalMoney}",
                    style: TextStyle(
                        fontSize: AdaptUI.rpx(30), color: UIColor.fontLevel),
                  ),
                )
              ])
            ])
          ],
        );
      default:
        return Row();
    }
  }

  Widget _headerHoleContainer(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(AdaptUI.rpx(30)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: UIColor.hexEEE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _headerInfoContainer(List<Widget> children) {
    return Container(
      margin: EdgeInsets.only(left: AdaptUI.rpx(30), top: AdaptUI.rpx(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
