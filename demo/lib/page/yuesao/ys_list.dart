import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/model/config_yswork_bean.dart';
import 'package:demo/model/level_bean.dart';
import 'package:demo/model/province_bean.dart';
import 'package:demo/model/year_filter_bean.dart';
import 'package:demo/model/ys_item_bean.dart';
import 'package:demo/model/ys_list_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/page/root/base_page_interface.dart';
import 'package:demo/slice/filter_nav_widget.dart';
import 'package:demo/slice/ys_filter_picker.dart';
import 'package:demo/slice/ys_wrap_filter.dart';
import 'package:demo/slice/ys_wrap_multi_filter.dart';
import 'package:demo/template/yuesao/cell_yuesao.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/data_line.dart';
import 'package:demo/utils/single_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/* 月嫂列表页 */
class YuesaoListPage extends StatefulWidget {
  @override
  _YuesaoListPageState createState() => _YuesaoListPageState();
}

class _YuesaoListPageState extends State<YuesaoListPage>
    with
        PageDataSource<YsItemBean>,
        SingleTickerProviderStateMixin,
        MultiDataLine {
  final String keyList = "key_list";

  String _listOrder = "1";
  String _forceDesc = "1";

  ConfigYsWorkBean configBean = ConfigYsWorkBean();

  /// 筛选省份
  ProvinceBean filterProvince;

  /// 服务天数
  String dayBuy = "26";

  /// 年龄数组
  List<YsFilterYearBean> yearFilterArray = gYearFilterArray;

  /// 筛选年龄
  YsFilterYearBean yearBean;

  /// 筛选等级
  List<LevelBean> levelBeanList;

  /// 筛选日期
  String predictDay = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<int>(keyList).onLoading();
    initData();
    onRefresh();
    loadYueSaoConfigWork();
  }

  void initData() {
    filterProvince = ProvinceBean("", "");
    yearBean = yearFilterArray[0];
  }

  /* 导航按钮点击 */
  void _navDidChanged(String listOrder, String forceDesc) {
    _listOrder = listOrder;
    _forceDesc = forceDesc;
    this.onRefresh();
  }

  /* 筛选配置 */
  void loadYueSaoConfigWork() async {
    XXNetwork.shared.post(params: {
      "methodName": "ConfigYuesaoOnwork",
    }).then((value) {
      return parseYsConfigCompute(value);
    }).then((config) {
      this.configBean = config;
      this.dayBuy = configBean.serviceDayArr?.first?.toString() ?? "26";
    });
  }

  @override
  void loadPageData() async {
    // TODO: implement _loadPageData
    super.loadPageData();

    var timestamp = "";
    if (null != predictDay && predictDay.isNotEmpty) {
      var time = DateTime.parse(predictDay);
      timestamp = (time.millisecondsSinceEpoch ~/ 1000).toString();
    }

    XXNetwork.shared.post(params: {
      "list_order": _listOrder,
      "force_desc": _forceDesc,
      "methodName": "YuesaoIndex",
      "day_buy": dayBuy,
      "size": "$size",
      "page": "$page",
      "level": "${levelBeanList?.map((e) => e.levelId)?.join(',') ?? 0}",
      "year": "${yearBean?.year ?? 0}",
      "region": "${filterProvince?.code ?? 0}",
      "predict_day": timestamp
    }).then((res) {
      return parseYsListCompute(res);
    }).then((ysData) {
      addList(ysData.data, ysData.page, ysData.total);
      getLine<int>(keyList).setData(DateTime.now().millisecondsSinceEpoch);
    }).catchError((err) {
      this.endRefreshing(status: false);
      if (list.isEmpty) {
        getLine<int>(keyList).setState(LineState.failure);
      }
    }).whenComplete(() {});
  }

  /* 点击进入月嫂详情 */
  void ysItemDidTap(YsItemBean item) {
    App.navigationTo(context, PageRoutes.ysDetailPage + '?id=${item.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("找月嫂"),
        elevation: 0,
      ),
      body: Column(children: [
        FilterNavWidget(
          onChanged: _navDidChanged,
          showFilter: this.filterShow,
        ),
        Expanded(
          child: getLine<int>(keyList).addObserver(
              onRefresh: this.onRefresh,
              builder: (context, _, __) => listWidget()),
        )
      ]),
    );
  }

  ///* 列表 */
  Widget listWidget() {
    return PageRefreshWidget(
      pageDataSource: this,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx, index) {
            YsItemBean item = list[index];
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
                  isCredit: item.isCredit == '1',
                  headPhoto: item.headPhoto,
                  level: item.level,
                  nickName: item.nickname,
                  desc: item.desc,
                  score: "${item.scoreComment}",
                  price: item.price,
                  service: item.service,
                  showCancel: false,
                ),
                onTapUp: (TapUpDetails detail) => this.ysItemDidTap(item),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }

  /* 筛选刷新指定widget的键key */

  /// 预产期日期
  final String keyPreDay = "key_preDay";

  /// 服务天数
  final String keyDayBuy = "key_dayBuy";

  /// 籍贯
  final String keyRegion = "key_region";

  BuildContext _filterSheetCtx;

  // 筛选窗弹出
  void filterShow() {
    showFilterSheet(context);
  }

  // 筛选确认
  void filterOkDidTap() {
    // 处理筛选参数
    this.onRefresh();
    this.filterTapDismiss();
  }

  // 筛选窗隐藏
  void filterTapDismiss() {
    if (_filterSheetCtx != null) {
      Navigator.of(_filterSheetCtx).pop();
      _filterSheetCtx = null;
    }
  }

  /// 等级筛选， 多选的
  void filterLevelIndexTap(List<int> indexArr) {
    this.levelBeanList =
        indexArr.map((e) => this.configBean.levelYusaoArr[e]).toList();
  }

  /// 籍贯picker
  SinglePicker _regionPicker;

  /* 籍贯选择 */
  void filterRegionPickerDidTap(_) {
    if (_regionPicker == null) {
      _regionPicker = SinglePicker(
          context, configBean.provinceYuesaoArr.map((e) => e.cityName).toList(),
          (_, index) {
        this.filterProvince = configBean.provinceYuesaoArr[index];
        getLine<String>(keyRegion).setData(this.filterProvince.cityName);
      });
    }
    _regionPicker.show();
  }

  /// 天数picker
  SinglePicker _servicePicker;

  /*服务天数选择*/
  void serviceDayPickerDidTap(_) {
    if (_servicePicker == null) {
      _servicePicker = SinglePicker(
          context, configBean.serviceDayArr.map((e) => e.toString()).toList(),
          (day, _) {
        this.dayBuy = day;
        getLine<String>(keyDayBuy).setData(this.dayBuy);
      });
    }
  }

  /* Sheet */
  showFilterSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (BuildContext ctx) {
          _filterSheetCtx = ctx;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                YsFilterPickerRowWidget(
                    height: AdaptUI.rpx(90),
                    title: "预约时间",
                    child:
                        getLine<String>(keyPreDay, initValue: this.predictDay)
                            .addObserver(builder: (context, data, _) {
                      return YsFilterSlice.pickerText(data, "请选择预约时间");
                    }),
                    tapAction: (tap) {
                      DatePicker.showDatePicker(context, onConfirm: (date) {
                        this.predictDay = date.toString().split(" ").first;
                        getLine<String>(keyPreDay).setData(this.predictDay);
                      }, currentTime: DateTime.now(), locale: LocaleType.zh);
                    }),
                YsFilterPickerRowWidget(
                    height: AdaptUI.rpx(100),
                    title: "服务天数",
                    child: getLine<String>(keyDayBuy, initValue: this.dayBuy)
                        .addObserver(
                            builder: (context, data, _) =>
                                YsFilterSlice.pickerText(data, "请选择服务天数")),
                    tapAction: serviceDayPickerDidTap),
                Container(
                  padding: EdgeInsets.only(
                      left: AdaptUI.rpx(30),
                      top: AdaptUI.rpx(20),
                      bottom: AdaptUI.rpx(20)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom:
                              BorderSide(color: UIColor.hexEEE, width: 0.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("等级"),
                      YsWrapMultiFilterWidget(
                        list: this
                            .configBean
                            ?.levelYusaoArr
                            ?.map((e) => e.title)
                            ?.toList(),
                        iwidth: AdaptUI.rpx(158),
                        iheight: AdaptUI.rpx(70),
                        margin: EdgeInsets.only(
                            top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                        textColor: UIColor.mainColor,
                        indexChanged: this.filterLevelIndexTap,
                        decorationIndexArr: (currentIndex, indexArr) {
                          return BoxDecoration(
                              color: indexArr.contains(currentIndex)
                                  ? UIColor.mainColor
                                  : Colors.white,
                              border: Border.all(
                                  width: 1, color: UIColor.mainColor));
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: AdaptUI.rpx(30),
                      top: AdaptUI.rpx(20),
                      bottom: AdaptUI.rpx(20)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom:
                              BorderSide(color: UIColor.hexEEE, width: 0.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("年龄"),
                      YsWrapFilterWidget(
                        list:
                            this.yearFilterArray?.map((e) => e.title)?.toList(),
                        iwidth: AdaptUI.rpx(158),
                        iheight: AdaptUI.rpx(70),
                        margin: EdgeInsets.only(
                            top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                        textColor: UIColor.mainColor,
                        itemChanged: (index) {
                          this.yearBean = this.yearFilterArray[index];
                        },
                        decoration: (currentIndex, selectedIndex) {
                          return BoxDecoration(
                              color: currentIndex == selectedIndex
                                  ? UIColor.mainColor
                                  : Colors.white,
                              border: Border.all(
                                  width: 1, color: UIColor.mainColor));
                        },
                      )
                    ],
                  ),
                ),
                YsFilterPickerRowWidget(
                  height: AdaptUI.rpx(100),
                  title: "籍贯",
                  child: getLine<String>(keyRegion, initValue: "").addObserver(
                      builder: (context, data, _) =>
                          YsFilterSlice.pickerText(data, "请选择籍贯")),
                  tapAction: filterRegionPickerDidTap,
                ),
                Container(
                  height: AdaptUI.rpx(150),
                  padding: EdgeInsets.only(
                      left: AdaptUI.rpx(120), right: AdaptUI.rpx(120)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: AdaptUI.rpx(220),
                          height: AdaptUI.rpx(80),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(child: Text("取消")),
                        ),
                        onTapUp: (tap) => this.filterTapDismiss(),
                      ),
                      GestureDetector(
                        child: Container(
                          width: AdaptUI.rpx(220),
                          height: AdaptUI.rpx(80),
                          decoration: BoxDecoration(
                              color: UIColor.mainColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                              child: Text(
                            "确定",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        onTapUp: (tap) => this.filterOkDidTap(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
