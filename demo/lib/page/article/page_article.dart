import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/common/color.dart';
import 'package:demo/common/common.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/data/corp_data.dart';
import 'package:demo/main.dart';
import 'package:demo/model/article_bean.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/page/root/app.dart';
import 'package:demo/slice/article_search.dart';
import 'package:demo/template/article/article_tabbarview.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 文章-tab
class PageArticle extends StatefulWidget {
  @override
  _PageArticleState createState() => _PageArticleState();
}

class _PageArticleState extends State<PageArticle>
    with PageDataSource<ArticleBean>, MultiDataLine, SingleTickerProviderStateMixin {
  List<ArticleCategoryBean> categoryList;

  List<ArticleBean> articleList;

  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLine<bool>("article_list").onLoading();
    loadCategoryList();
  }

  /// 获取文章分类列表
  void loadCategoryList() async {
    XXNetwork.shared
        .post(params: {"methodName": "ArticleCategoryList"}).then((res) {
      var categoryList = (res["data"] as List)
          ?.map((e) => e == null ? null : ArticleCategoryBean.fromJson(e))
          ?.toList();
      _controller =
          TabController(length: categoryList.length, vsync: this);

//      setState(() {
        this.categoryList = categoryList;
//      });
      getLine<bool>("article_list").setData(true, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Consumer<CorpData>(
              builder: (context, corp, _) => Text(corp.corpBean.titleJiaJia)
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: getLine<bool>("article_list").addObserver(
          builder: (ctx, data, _) {
            return Container(
              child: Column(
                children: [
                  Container(
                    height: AdaptUI.rpx(100),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: UIColor.hexEEE))),
                    child: TabBar(
                      controller: _controller,
                      isScrollable: true,
                      indicatorColor: UIColor.mainColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: UIColor.mainColor,
                      labelStyle: TextStyle(
                          fontSize: AdaptUI.rpx(32), fontWeight: FontWeight.bold),
                      unselectedLabelColor: UIColor.hex333,
                      unselectedLabelStyle: TextStyle(
                          fontSize: AdaptUI.rpx(28), fontWeight: FontWeight.normal),
                      tabs: categoryList?.map((e) {
                        return Text(e.title);
                      })?.toList() ??
                          [],
                    ),
                  ),
                  ArticleSearchWidget(
                    tap: () {
                      App.navigationTo(context, PageRoutes.searchArticle);
                    },
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: categoryList?.map((e) {
                        return ArticleTabBarView(
                          categoryId: e.id,
                        );
                      })?.toList() ??
                          [],
                    ),
                  )
                ],
              ),
            );
          }
        ) );
  }
}
