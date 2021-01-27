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
import 'package:demo/utils/v_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/// 订单提交-服务信息
class OrderServerShortWidget extends StatefulWidget {

  final List<String> serviceDayArr;

  final TDIntCallBack onBabyNumCallBack;

  final TDStringCallBack onPreDateCallBack;

  final TDStringCallBack onServiceDayCallBack;

  final VoidCallback onShortTap;

  OrderServerShortWidget({Key key, this.serviceDayArr, this.onServiceDayCallBack, this.onBabyNumCallBack, this.onPreDateCallBack, this.onShortTap}): super(key: key);

  @override
  _OrderServerShortWidgetState createState() => _OrderServerShortWidgetState();
}

class _OrderServerShortWidgetState extends State<OrderServerShortWidget>
    with MultiDataLine {
  /// 预产期key
  final String keyPre = "pre_day";
  /// 服务天数
  final String keyServer = "pre_server";
  /// 预产期
  String _dateStr = "";
  /// 服务天数
  SinglePicker _picker;

  double _dayValue;


  final List<XXIntTitleBean> _babyArr = gBabyArray;

  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dayValue = double.parse(widget.serviceDayArr.first ?? '1') ?? 1;
    _picker = SinglePicker(context, widget.serviceDayArr, (value, _) {
      _dayValue = double.parse(value);
      getLine<String>(keyServer).setData(value);
      widget.onServiceDayCallBack(value);
    });
    _tapGestureRecognizer.onTap = widget.onShortTap;
  }

  // 点击增加0.5天
  void serverDayAddHalf(tap) {
    if (_dayValue <= 25) {
      _dayValue = _dayValue + 0.5;
      getLine<String>(keyServer).setData(_dayValue.toString());
    } else {
      VToast.show("短单少于26天");
    }
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
        Row(
          children: [
            Container(
              width: AdaptUI.rpx(600),
              child: YsFilterPickerRowWidget(
                height: AdaptUI.rpx(110),
                title: "服务天数",
                child: getLine<String>(keyServer, initValue: widget.serviceDayArr.first ?? '').addObserver(
                    builder: (ctx, day, _) => YsPickerContentTextWidget(
                      text: day,
                      placeholder: "请选择服务天数",
                    )),
                tapAction: serverDayDidTap,
              ),
            )
            ,
            GestureDetector(
              onTapUp: this.serverDayAddHalf,
              child: Container(
                width: AdaptUI.rpx(110),
                height: AdaptUI.rpx(70),
                color: UIColor.mainLight,
                child: Center(child: Text("+0.5天", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),) ,
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(AdaptUI.rpx(30), AdaptUI.rpx(20), AdaptUI.rpx(30), AdaptUI.rpx(30)),
          color: Colors.white,
          child: RichText(
            text: TextSpan(
                children: [
                  TextSpan(text: "注:可选择1-25天之间的天数,26天及以上天数请从", style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(26))),
                  TextSpan(text: "找月嫂", style: TextStyle(color: UIColor.mainColor, fontSize: AdaptUI.rpx(26)), recognizer: _tapGestureRecognizer),
                  TextSpan(text: "中下单,价格更优惠哦~", style: TextStyle(color: UIColor.hex666, fontSize: AdaptUI.rpx(26))),
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
