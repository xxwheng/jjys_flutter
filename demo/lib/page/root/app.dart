
import 'package:demo/page/mine/ys_collect.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route_handles.dart';

class App {
  static FluroRouter router;

  static void navigationTo(BuildContext context, String path) {
    router.navigateTo(context, path, transition: TransitionType.cupertino);
  }
}

class PageRoutes {
  /* 底层控制器 */
  static String tabBarController = "/";

  /* 文章搜索页 */
  static String searchArticle = "/page/article/page_article_search";

  // 我的关注
  static String myCollect = "/page/mine/ys_collect";

  /* 月嫂列表 */
  static String ysListPage = "/page/yuesao/ys_list";

  /* 育婴师列表 */
  static String yyListPage = "/page/yuying/yy_list";

  /* 月嫂详情 */
  static String ysDetailPage = "/page/yuesao/ys_detail";

  /* 加盟商选择列表 */
  static String corpListPage = "/page/home/page_corp_list";

  /* 登录页 */
  static String loginPage = "/page/mine/login_page";

  /* 单一网页嵌套 */
  static String singleWebPage = "/components/web/single_web";

  static void configFluroRoutes(FluroRouter router) {
    router.define(tabBarController, handler: tabBarHandler);
    router.define(searchArticle, handler: searchArticleHandler);
    router.define(myCollect, handler: myCollectPageHandler);
    router.define(ysListPage, handler: ysListPageHandler);
    router.define(ysDetailPage, handler: ysDetailPageHandler);
    router.define(yyListPage, handler: yuyingListPageHandler);
    router.define(corpListPage, handler: corpListPageHandler);
    router.define(loginPage, handler: loginPageHandler);
    router.define(singleWebPage, handler: singleWebPageHandler);
  }
}
