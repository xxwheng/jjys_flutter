import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/data/global_define.dart';
import 'package:demo/model/xx_int_title.dart';
import 'package:demo/slice/ys_filter_picker.dart';
import 'package:demo/slice/ys_wrap_filter.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/dialog/coupon_dialog.dart';
import 'package:demo/utils/single_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/// 订单提交-服务信息
class OrderServerYsWidget extends StatefulWidget {

  final List<String> serviceDayArr;

  final TDIntCallBack onBabyNumCallBack;

  final TDStringCallBack onPreDateCallBack;

  final TDStringCallBack onServiceDayCallBack;

  final VoidCallback onShortTap;

  OrderServerYsWidget({Key key, this.serviceDayArr, this.onServiceDayCallBack, this.onBabyNumCallBack, this.onPreDateCallBack, this.onShortTap}): super(key: key);

  @override
  _OrderServerYsWidgetState createState() => _OrderServerYsWidgetState();
}

class _OrderServerYsWidgetState extends State<OrderServerYsWidget>
    with MultiDataLine {
  /// 预产期key
  final String keyPre = "pre_day";
  /// 服务天数
  final String keyServer = "pre_server";
  /// 预产期
  String _dateStr = "";
  /// 服务天数
  SinglePicker _picker;

  final List<XXIntTitleBean> _babyArr = gBabyArray;

  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _picker = SinglePicker(context, widget.serviceDayArr, (value, _) {
        print(value);
        getLine<String>(keyServer).setData(value);
        widget.onServiceDayCallBack(value);
    });
    _tapGestureRecognizer.onTap = widget.onShortTap;
  }



  // 服务天数点击筛选
  void serverDayDidTap(_) {
    _picker.show();
  }

  // 预产期点击筛选
  void preDayDidTap(_) {
    DatePicker.showDatePicker(context, currentTime: DateTime.now(), locale: LocaleType.zh, onConfirm: (date) {
      this._dateStr = date.toString().split(" ").first;
      getLine<String>(keyPre).setData(this._dateStr);
      var stamp = (date.millisecondsSinceEpoch~/1000).toString();
      widget.onPreDateCallBack(stamp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: AdaptUI.rpx(30), left: AdaptUI.rpx(30), bottom: AdaptUI.rpx(20)),
          child: Text("服务信息", style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(30)),),
        ),
        YsFilterPickerRowWidget(
          height: AdaptUI.rpx(110),
          title: "预产期",
          child: getLine<String>(keyPre, initValue: _dateStr).addObserver(
              builder: (ctx, date, _) => YsPickerContentTextWidget(
                    text: _dateStr,
                    placeholder: "请选择您的预产期",
                  )),
          tapAction: preDayDidTap,
        ),
        YsFilterPickerRowWidget(
          height: AdaptUI.rpx(110),
          title: "宝贝数量",
          child: YsWrapFilterWidget(
            list: _babyArr.map((e) => e.title).toList(),
            iwidth: AdaptUI.rpx(150),
            iheight: AdaptUI.rpx(60),
            margin: EdgeInsets.only(right: AdaptUI.rpx(40)),
            textColor: UIColor.mainColor,
            itemChanged: (index) {
              widget.onBabyNumCallBack(_babyArr[index].num);
            },
            decoration: (currentIndex, selectedIndex) {
              return BoxDecoration(
                  color: currentIndex == selectedIndex
                      ? UIColor.mainColor
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(AdaptUI.rpx(30))),
                  border: Border.all(
                      width: 0.5, color: UIColor.mainColor));
            },
          ),
        ),
        YsFilterPickerRowWidget(
          height: AdaptUI.rpx(110),
          title: "服务天数",
          child: getLine<String>(keyServer, initValue: "26").addObserver(
              builder: (ctx, day, _) => YsPickerContentTextWidget(
                text: day,
                placeholder: "请选择服务天数",
              )),
          tapAction: serverDayDidTap,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(AdaptUI.rpx(30), AdaptUI.rpx(20), AdaptUI.rpx(30), AdaptUI.rpx(30)),
          color: Colors.white,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "注:可输入26及以上的任意天数，25天及以下天数请从", style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(26))),
                TextSpan(text: "短期月子护理", style: TextStyle(color: UIColor.mainColor, fontSize: AdaptUI.rpx(26)), recognizer: _tapGestureRecognizer),
                TextSpan(text: "中预约", style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(26))),
              ]
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    _tapGestureRecognizer.dispose();
    super.dispose();
  }
}
