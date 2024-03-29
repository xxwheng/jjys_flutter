import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/components/singlePage/single_dataSource.dart';
import 'package:demo/components/singlePage/single_refresh_widget.dart';
import 'package:demo/data/bean_compute.dart';
import 'package:demo/data/config_data.dart';
import 'package:demo/data/corp_data.dart';
import 'package:demo/data/key_event_bus.dart';
import 'package:demo/model/article_bean.dart';
import 'package:demo/model/home_bean.dart';
import 'package:demo/native/ios/mine_bridge.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/app_title_widget.dart';
import 'package:demo/slice/article_widget.dart';
import 'package:demo/slice/home_comment.dart';
import 'package:demo/slice/home_learn_more.dart';
import 'package:demo/slice/home_ys_top.dart';
import 'package:demo/template/home/menu_scroll.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/event_bus.dart';
import 'package:demo/utils/multi_picker.dart';
import 'package:demo/utils/ys_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:xx_pay/xx_pay.dart';
import '../../common/color.dart';
import '../../model/home_bean.dart';
import '../../template/home/menu_scroll.dart';

/// 首页-tab
class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome>
    with SingleDataSource, MultiDataLine {
  /// 首页数据
  HomeBean homeData;

  /// 文章数据
  List<ArticleBean> articleList;

  /// 处理flutter_swiper组件 loop为true时 初始化滑动很多次问题
  bool _bannerLoop = false;

  final String key = "homeKey";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<int>(key).onLoading();
    this.onRefresh();
    eventBus.on(EventBusKey.corpChanged, (arg) { this.onRefresh(); });
  }

  /// 加盟商切换
  void corpChooseDidTap() {
    App.navigationTo(context, PageRoutes.corpListPage).then((value) {
      eventBus.emit(EventBusKey.corpChanged);
    });
  }

  /// banner点击
  void bannerItemDidTap(index) {
    var item = homeData.banner[index];
  }

  /// 菜单按钮点击
  void menuItemDidTap(HomeMenuBean bean) {

    switch (bean.id.toString()) {
      case "1":
        App.navigationTo(context, PageRoutes.ysListPage);
        break;
      case "2":
        App.navigationTo(context, PageRoutes.shortOrderCommitPage);
        break;
      case "4":
        App.navigationTo(context, PageRoutes.yyListPage);
        break;
      default:
        break;
    }
  }

  @override
  void onRefresh() {
    loadHomeData();
  }

  /// 首页数据
  void loadHomeData() {
    Future.wait([
      XXNetwork.shared.post(params: {
        "methodName": "YuesaoHome",
      }),
      XXNetwork.shared.post(params: {
        "methodName": "ArticleList",
        "size": 5,
      })
    ]).then((value) {
      return Future.wait(
          [parseHomeBeanCompute(value[0]), parseArticleListCompute(value[1])]);
    }).then((res) {
      this.homeData = res[0];
      this.articleList = (res[1] as ArticleListBean).list;
      getLine<int>(key).setData(DateTime.now().millisecondsSinceEpoch);
    }).catchError((err) {
      logger.i(err);
      getLine<int>(key).onFailure();
    }).whenComplete(() => this.endRefreshing());
  }

  /// 加盟商配置信息
  void loadConfigCorp() {
    XXNetwork.shared.post(params: {
      "methodName": "ConfigCorp"
    }).then((json) {
      return parseConfigCorpCompute(json);
    }).then((value) {
      ConfigData.shared.configCorpBean = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.i("首页Build");
    return Scaffold(
      appBar: AppBar(
        title: AppTitleWidget(),
        centerTitle: true,
        elevation: 0,
        leadingWidth: AdaptUI.rpx(150),
        leading: leftBarItem(),
      ),
      backgroundColor: UIColor.pageColor,
      body: getLine<int>(key).addObserver(
          onRefresh: this.onRefresh,
          builder: (ctx, data, _) {
            return pageWidget();
          }),
    );
  }

  /* 左侧按钮 */
  Widget leftBarItem() {
    return GestureDetector(
      onTap: this.corpChooseDidTap,
      child: Container(
        padding: EdgeInsets.only(left: AdaptUI.rpx(20)),
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
            ),
            Consumer<CorpData>(
                builder: (context, corp, _) => Expanded(
                  child: Text(corp.corpBean.city, overflow: TextOverflow.ellipsis,),
                )

                    )
          ],
        ),
      ),
    );
  }

  /// 点击文章
  void articleDidTap(ArticleBean e) {
    MineNativeBridge.shared.gotoArticleWeb(e.id, e.title);
  }

  // 页面
  Widget pageWidget() {
    return SingleRefreshWidget(
      dataSource: this,
      child: ListView(
        children: [
          homeData.banner.length == 0 ? Row() : Container(
            height: AdaptUI.rpx(280),
            child: Swiper(
              loop: _bannerLoop,
              autoplay: true,
              itemCount: homeData.banner.length,
              pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      activeColor: UIColor.mainColor)),
              itemBuilder: (context, index) {
                var item = homeData.banner[index];
                return CachedNetworkImage(
                    imageUrl: item.image.toString(), fit: BoxFit.cover);
              },
              onTap: bannerItemDidTap,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
            padding:
                EdgeInsets.only(top: AdaptUI.rpx(30), bottom: AdaptUI.rpx(20)),
            color: Colors.white,
            child: MenuScrollWidget(
              menuList:
                  homeData.menuList?.map((e) => e.title.toString())?.toList() ??
                      [],
              builer: _menuItemWidgetBuilder,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
            child: Row(
              children: homeData.adArr?.asMap()?.keys?.map((index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: index == 0
                              ? Border(right: BorderSide(color: UIColor.hexEEE))
                              : null),
                      height: AdaptUI.rpx(200),
                      width: AdaptUI.screenWidth / 2,
                      child: CachedNetworkImage(
                        imageUrl: homeData.adArr[index].thumb.toString(),
                        fit: BoxFit.cover,
                      ),
                    );
                  })?.toList() ??
                  [],
            ),
          ),
          homeData.yuesaoTopList.length == 0
              ? Row()
              : Container(
                  margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                  color: Colors.white,
                  child: Column(
                    children: [
                      HomeLearnMoreHeaderWidget(
                        title: "月嫂之星",
                        margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                        tap: () => App.navigationTo(context, PageRoutes.ysListPage),
                      ),
                      Container(
                        height: AdaptUI.rpx(470),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeData?.yuesaoTopList?.length ?? 0,
                          itemBuilder: (context, index) {
                            HomeTopYuesaoBean item =
                                homeData.yuesaoTopList[index];
                            return GestureDetector(
                              onTapUp: (tap) => App.navigationTo(context, PageRoutes.ysDetailPage + '?id=${item.id}'),
                              child: HomeYuesaoTopWidget(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? AdaptUI.rpx(30) : 0,
                                    top: AdaptUI.rpx(20),
                                    bottom: AdaptUI.rpx(40),
                                    right: AdaptUI.rpx(20)),
                                imageUrl: item.info_yuesao.headPhoto,
                                name: item.info_yuesao.provinceName +
                                    "·" +
                                    item.info_yuesao.nickname,
                                levelStr: YsLevel.getYuesaoLevel(
                                    item.info_yuesao.level),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
          homeData.commentList.length == 0
              ? Row()
              : Container(
                  margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                  color: Colors.white,
                  child: Column(
                    children: [
                      HomeLearnMoreHeaderWidget(
                        tap: () => MineNativeBridge.shared.gotoCommentWeb(),
                        title: "美妈点评",
                        margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(AdaptUI.rpx(30),
                            AdaptUI.rpx(20), AdaptUI.rpx(30), AdaptUI.rpx(30)),
                        height: AdaptUI.rpx(500),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: UIColor.hexEEE, width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Color.fromRGBO(221, 221, 221, 0.4))
                          ],
                        ),
                        child: Swiper(
                          loop: _bannerLoop,
                          autoplay: true,
                          itemCount: homeData?.commentList?.length ?? 0,
                          pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  size: 6,
                                  activeSize: 6,
                                  activeColor: UIColor.mainColor,
                                  color: Color.fromRGBO(0, 0, 0, 0.2))),
                          itemBuilder: (context, index) {
                            var item = homeData.commentList[index];
                            return HomeCommentWidget(
                              headPhoto: item.headPhoto,
                              username: item.username,
                              score: int.parse(item.score.toString()),
                              createTime: item.createAt.toString(),
                              serverDays: item.productDays,
                              content: item.content,
                              picList: item.image,
                            );
                          },
                          onTap: bannerItemDidTap,
                        ),
                      )
                    ],
                  )),
          articleList.length == 0
              ? Row()
              : Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                  padding: EdgeInsets.only(bottom: AdaptUI.rpx(40)),
                  child: Column(
                    children: [
                      HomeLearnMoreHeaderWidget(
                        title: "孕育知识",
                        margin: EdgeInsets.only(top: AdaptUI.rpx(20)),
                        tap: () => App.switchTabBar(context, 1),
                      ),
                      ...articleList.map((e) {
                        return GestureDetector(
                          onTapUp: (tap) => this.articleDidTap(e),
                          child: ArticleWidget(
                            imageUrl: e.image,
                            title: e.title,
                            desc: e.desc,
                          ),
                        ) ;
                      }).toList()
                    ],
                  ),
                )
        ],
      ),
    );
  }

  /// 菜单导航按钮
  Widget _menuItemWidgetBuilder(context, index) {
    HomeMenuBean item = homeData.menuList[index];
    return GestureDetector(
      onTapUp: (tap) => menuItemDidTap(item),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AdaptUI.rpx(80),
            height: AdaptUI.rpx(80),
            child: CachedNetworkImage(
              imageUrl: item.thumb,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: AdaptUI.rpx(10)),
            child: Center(
              child: Text(item.title),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    eventBus.off(EventBusKey.corpChanged);
    dataBusDispose();
    super.dispose();
  }
}
