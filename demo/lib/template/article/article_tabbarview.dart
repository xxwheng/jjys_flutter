import 'package:adaptui/adaptui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/components/pageList/page_dataSource.dart';
import 'package:demo/components/pageList/page_refresh_widget.dart';
import 'package:demo/model/article_bean.dart';
import 'package:demo/native/ios/mine_bridge.dart';
import 'package:demo/network/manager/xx_network.dart';
import 'package:demo/slice/article_widget.dart';
import 'package:demo/utils/bus/data_bus.dart';
import 'package:demo/utils/bus/data_line.dart';
import 'package:flutter/material.dart';

/// 文章 分页
class ArticleTabBarView extends StatefulWidget {
  final String categoryId;

  ArticleTabBarView({Key key, this.categoryId}) : super(key: key);

  @override
  _ArticleTabBarViewState createState() => _ArticleTabBarViewState();
}

class _ArticleTabBarViewState extends State<ArticleTabBarView>
    with PageDataSource<ArticleBean>, MultiDataLine, AutomaticKeepAliveClientMixin {
  String key;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    key = widget.categoryId + "_key";
    getLine<bool>(key).onLoading();
    onRefresh();
  }

  @override
  void loadPageData() {
    // TODO: implement loadPageData
    super.loadPageData();
    XXNetwork.shared.post(params: {
      "methodName": "ArticleList",
      "category_id": widget.categoryId,
      "size": "$size",
      "page": "$page",
    }).then((res) {
      var articleList = (res['data'] as List)
          ?.map((e) => e == null ? null : ArticleBean.fromJson(e))
          ?.toList();
      var page = int.parse(res['page'].toString());
      var total = int.parse(res['total'].toString());
      addList(articleList, page, total);
      getLine<bool>(key).setData(true, true);
    }).catchError((err) {
      getLine<bool>(key).setState(LineState.failure);
      this.endRefreshing(status: false);
    });
  }

  /// 点击文章
  void articleDidTap(ArticleBean e) {
    MineNativeBridge.shared.gotoArticleWeb(e.id, e.title);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AdaptUI.rpx(10), bottom: AdaptUI.rpx(40)),
      color: Colors.white,
      child: getLine<bool>(key)
          .addObserver(builder: (ctx, _, __) => _getRefreshWidget()),
    );
  }

  Widget _getRefreshWidget() {
    return PageRefreshWidget(
      pageDataSource: this,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            ArticleBean item = list[index];
            return GestureDetector(
              onTapUp: (tap) => this.articleDidTap(item),
              child: ArticleWidget(
                imageUrl: item.image,
                title: item.title,
                desc: item.desc,
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
}
