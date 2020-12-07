import 'package:demo/common/common.dart';
import 'package:demo/components/web/single_web.dart';
import 'package:demo/data/web_url_bridge.dart';
import 'package:demo/page/article/page_article_search.dart';
import 'package:demo/page/home/page_corp_list.dart';
import 'package:demo/page/mine/login_page.dart';
import 'package:demo/page/mine/my_coupon.dart';
import 'package:demo/page/mine/ys_collect.dart';
import 'package:demo/page/root/tab_bar.dart';
import 'package:demo/page/yuesao/ys_detail.dart';
import 'package:demo/page/yuying/yy_list.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/page/yuesao/ys_list.dart';

/* 底层控制器页 */
var tabBarHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        TabBarController());

/* 文章-文章搜索页 */
var searchArticleHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        PageArticleSearch());

/* 我的-我的关注*/
var myCollectPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        YsCollectPage());

/* 首页-月嫂列表 */
var ysListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        YuesaoListPage());

/* 首页-育婴师列表 */
var yuyingListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        YuyingListPage());

/* 月嫂详情 */
var ysDetailPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        YsDetailPage());

/* 加盟商列表 */
var corpListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        PageCorpList());

/* 登录页 */
var loginPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        LoginPage());

/* 单一网页 */
var singleWebPageHandler =
Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  logger.i(params);
  String title = params["title"]?.first?.toString();
  String url = params["url"]?.first?.toString();
  return SingleWebPage(title: title, url: url);
});

/* 我的优惠券 */
var myCouponPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        MyCouponListPage());
