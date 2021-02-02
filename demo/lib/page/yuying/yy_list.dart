import 'package:adaptui/adaptui.dart';
import 'package:demo/common/color.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/model/config_yswork_bean.dart';
import 'package:demo/model/level_bean.dart';
import 'package:demo/model/province_bean.dart';
import 'package:demo/model/year_filter_bean.dart';
import 'package:demo/model/ys_item_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/* 育婴师列表页 */
class YuyingListPage extends StatefulWidget {
  @override
  _YuyingListPageState createState() => _YuyingListPageState();
}

class _YuyingListPageState extends State<YuyingListPage>
    with
        PageDataSource<YsItemBean>,
        SingleTickerProviderStateMixin,
        MultiDataLine {
  final String _keyList = "key_list";
  final String _keyWork = "workKey";

  String _listOrder = "1";
  String _forceDesc = "1";

  ConfigYsWorkBean configBean = ConfigYsWorkBean();

  /// 年龄数组
  List<YsFilterYearBean> yearFilterArray = gYearFilterArray;

  /// 筛选年龄
  YsFilterYearBean yearBean;

  /// 育婴师分类 筛选
  List<YuyingFilterCareTypeBean> careTypeFilterArray = gCareTypeFilterArray;
  YuyingFilterCareTypeBean careTypeBean;

  /// 筛选省份
  ProvinceBean filterProvince;

  /// 筛选等级
  List<LevelBean> levelBeanList;

  /// 筛选日期
  String predictDay = "";

  /// 弹窗上下文
  BuildContext _filterSheetCtx;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<int>(_keyList).onLoading();
    initData();
    onRefresh();
    loadYuyingConfigWork();
  }

  void initData() {
    filterProvince = ProvinceBean("", "");
    yearBean = yearFilterArray[0];
    careTypeBean = careTypeFilterArray[0];
  }

  /* 导航按钮点击 */
  void _navDidChanged(String listOrder, String forceDesc) {
    _listOrder = listOrder;
    _forceDesc = forceDesc;
    this.onRefresh();
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
      "methodName": "SkillerYuyingIndex",
      "day_buy": 0,
      "care_type": careTypeBean.id,
      "size": "$size",
      "page": "$page",
      "level": "${levelBeanList?.map((e) => e.levelId)?.join(',') ?? 0}",
      "region": "${filterProvince?.code ?? 0}",
      "predict_day": timestamp
    }).then((res) {
      return parseYsListCompute(res);
    }).then((value) {
      addList(value.data, value.page, value.total);
      getLine<int>(_keyList).setData(DateTime.now().millisecond);
    }).catchError((err) {
      this.endRefreshing(status: false);
      if (list.isEmpty) {
        getLine<int>(_keyList).setState(LineState.failure);
      }
    }).whenComplete(() {});
  }

  /* 筛选配置 */
  void loadYuyingConfigWork() async {
    XXNetwork.shared.post(params: {
      "methodName": "ConfigYuesaoOnwork",
    }).then((value) {
      return parseYsConfigCompute(value);
    }).then((bean) {
      this.configBean = bean;
    });
  }

  /* 点击进入育婴师详情 */
  void ysItemDidTap(YsItemBean item) {
    App.navigationTo(context, PageRoutes.yyDetailPage + "?id=" + item.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("找育婴师"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FilterNavWidget(
            onChanged: _navDidChanged,
            showFilter: this.filterShow,
          ),
          Positioned(
            top: AdaptUI.rpx(120),
            left: 0,
            right: 0,
            bottom: 0,
            child: getLine<int>(_keyList).addObserver(
              builder: (ctx, data, _) => pageListWidget(),
            ),
          ),
        ],
      ),
    );
  }

  /* 列表 */
  Widget pageListWidget() {
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
                type: JJRoleType.nurse,
                isCredit: item.isCredit.toString() == '1',
                headPhoto: item.headPhoto,
                level: item.level,
                careType: item.careType,
                nickName: item.nickname,
                desc: item.desc,
                score: "${item.scoreComment}",
                price: "${item.price}",
                service: "${item.service}",
                showCancel: false,
              ),
              onTapUp: (TapUpDetails detail) => this.ysItemDidTap(item),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dataBusDispose();
    super.dispose();
  }

  /* 筛选刷新指定widget的键key */
  final String keyPreDay = "key_preDay";
  final String keyRegion = "key_region";

  // 筛选窗弹出
  void filterShow() {
    _showFilterSheet(context);
  }

  // 筛选确认
  void filterOkDidTap() {
    // 处理筛选参数
    this.onRefresh();
    this.filterTapDimiss();
  }

  // 筛选窗隐藏
  void filterTapDimiss() {
    if (_filterSheetCtx != null) {
      Navigator.of(_filterSheetCtx).pop();
      _filterSheetCtx = null;
    }
  }

  /* 预约时间筛选 */
  void filterDatePickerDidTap() {
    print("timePicker");
    DatePicker.showDatePicker(context, onConfirm: (date) {
      this.predictDay = date.toString().split(" ").first;
      getLine<String>(keyPreDay).setData(this.predictDay);
    }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }

  /* 等级筛选， 多选的  */
  void filterLevelIndexTap(List<int> indexArr) {
    this.levelBeanList =
        indexArr.map((e) => this.configBean.levelYuyingArr[e]).toList();
  }

  /* 育婴师分类筛选 */
  void filterCareTypeIndexTap(int index) {
    this.careTypeBean = this.careTypeFilterArray[index];
  }

  /* 年龄筛选 */
  void filterYearIndexTap(int index) {
    this.yearBean = this.yearFilterArray[index];
  }


  /// 籍贯picker
  SinglePicker _regionPicker;
  /* 籍贯选择 */
  void filterRegionPickerDidTap() {
    if (_regionPicker == null) {
      _regionPicker = SinglePicker(context, configBean.provinceYuyingArr.map((e) => e.cityName).toList(), (_, index) {
        this.filterProvince = configBean.provinceYuyingArr[index];
        getLine<String>(keyRegion).setData(this.filterProvince.cityName);
      });
    }
    _regionPicker.show();
  }

  /* Sheet */
  _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (BuildContext ctx) {
          _filterSheetCtx = ctx;
          return SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              YsFilterPickerRowWidget(
                height: AdaptUI.rpx(90),
                title: "预约时间",
                child: getLine<String>(keyPreDay, initValue: this.predictDay)
                    .addObserver(builder: (context, data, _) {
                  return YsFilterSlice.pickerText(data, "请选择预约时间");
                }),
                tapAction: (tap) => this.filterDatePickerDidTap(),
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
                        bottom: BorderSide(color: UIColor.hexEEE, width: 0.5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("等级"),
                    YsWrapMultiFilterWidget(
                      list: this
                          .configBean
                          ?.levelYuyingArr
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
                            border:
                                Border.all(width: 1, color: UIColor.mainColor));
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
                        bottom: BorderSide(color: UIColor.hexEEE, width: 0.5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("育婴师分类"),
                    YsWrapFilterWidget(
                      list: this
                          .careTypeFilterArray
                          ?.map((e) => e.title)
                          ?.toList(),
                      iwidth: AdaptUI.rpx(158),
                      iheight: AdaptUI.rpx(70),
                      margin: EdgeInsets.only(
                          top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                      textColor: UIColor.mainColor,
                      itemChanged: this.filterCareTypeIndexTap,
                      decoration: (currentIndex, selectedIndex) {
                        return BoxDecoration(
                            color: currentIndex == selectedIndex
                                ? UIColor.mainColor
                                : Colors.white,
                            border:
                                Border.all(width: 1, color: UIColor.mainColor));
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
                        bottom: BorderSide(color: UIColor.hexEEE, width: 0.5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("年龄"),
                    YsWrapFilterWidget(
                      list: this.yearFilterArray?.map((e) => e.title)?.toList(),
                      iwidth: AdaptUI.rpx(158),
                      iheight: AdaptUI.rpx(70),
                      margin: EdgeInsets.only(
                          top: AdaptUI.rpx(20), right: AdaptUI.rpx(20)),
                      textColor: UIColor.mainColor,
                      itemChanged: this.filterYearIndexTap,
                      decoration: (currentIndex, selectedIndex) {
                        return BoxDecoration(
                            color: currentIndex == selectedIndex
                                ? UIColor.mainColor
                                : Colors.white,
                            border:
                                Border.all(width: 1, color: UIColor.mainColor));
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
                tapAction: (tap) => this.filterRegionPickerDidTap(),
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(child: Text("取消")),
                      ),
                      onTapUp: (tap) => this.filterTapDimiss(),
                    ),
                    GestureDetector(
                      child: Container(
                        width: AdaptUI.rpx(220),
                        height: AdaptUI.rpx(80),
                        decoration: BoxDecoration(
                            color: UIColor.mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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
            ]),
          );
        });
  }
}
