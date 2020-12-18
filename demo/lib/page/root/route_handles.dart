import 'package:demo/common/common.dart';
import 'package:demo/components/web/single_web.dart';
import 'package:demo/data/global_data.dart';
import 'package:demo/data/web_url_bridge.dart';
import 'package:demo/page/article/page_article_search.dart';
import 'package:demo/page/home/page_corp_list.dart';
import 'package:demo/page/mine/login_page.dart';
import 'package:demo/page/mine/my_coupon.dart';
import 'package:demo/page/mine/my_info.dart';
import 'package:demo/page/mine/my_info_nickname.dart';
import 'package:demo/page/mine/ys_collect.dart';
import 'package:demo/page/order/order_ys_commit.dart';
import 'package:demo/page/root/tab_bar.dart';
import 'package:demo/page/yuesao/work_show.dart';
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
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      String id = params['id']?.first?.toString();
      return YsDetailPage(id: id);
    });

var ysWorkShowHandler = Handler(
  handlerFunc: (ctx, Map<String, dynamic> params) {
    String id = params['id']?.first?.toString();
    JJRoleType type = jjRoleType(int.parse(params['type']?.first?.toString()));
    return YsWorkShowPage(id: id, type: type,);
  }
);

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

var myInfoPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => MyInfoPage());

/* 我的优惠券 */
var myCouponPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        MyCouponListPage());

/* 修改个人昵称*/
var myInfoNickNameHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) => MyInfoNickNamePage()
);

/* 月嫂提交订单页 */
var ysOrderCommitHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    String id = params['id']?.first?.toString();
    return OrderYsCommitPage(id: id);
  }
);