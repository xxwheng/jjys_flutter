import 'dart:convert';

import 'package:demo/model/article_bean.dart';
import 'package:demo/model/city_bean.dart';
import 'package:demo/model/config_corp_bean.dart';
import 'package:demo/model/config_yswork_bean.dart';
import 'package:demo/model/corp_grop_bean.dart';
import 'package:demo/model/home_bean.dart';
import 'package:demo/model/ys_comment_list.dart';
import 'package:demo/model/ys_detail_bean.dart';
import 'package:demo/model/ys_list_bean.dart';
import 'package:demo/network/dio/http_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/* compute 解析 */

Future<List<CityBean>> parseLocalCityCompute() async {
  var value =  await rootBundle.loadString("lib/data/city.json");
  return compute(_parseLocalCity, value) ;
}

List<CityBean> _parseLocalCity(value) {
  List jsonList = json.decode(value);
  return jsonList.map((e) => e==null?null:CityBean.fromJson(e))?.toList();
}

/// 首页
HomeBean _parseHomeBean(dynamic json) {
  HomeBean bean = HomeBean.fromJson(json);
  bean.adArr = [];
  if (bean.homeAdLeftBean != null) {
    bean.adArr.add(bean.homeAdLeftBean);
  }
  if (bean.homeAdRightBean != null) {
    bean.adArr.add(bean.homeAdRightBean);
  }
  // 菜单图标没有域名
  bean.menuList.forEach((e) {
    if (e.thumb.isNotEmpty && !e.thumb.contains("http")) {
      e.thumb = HttpConfig.webUrl + e.thumb;
    }
  });
  // 月嫂之星头像没有域名
  bean.yuesaoTopList.forEach((e) {
    if (e.info_yuesao.headPhoto.isNotEmpty &&
        !e.info_yuesao.headPhoto.contains("http")) {
      e.info_yuesao.headPhoto = HttpConfig.webUrl + e.info_yuesao.headPhoto;
    }
  });
  return bean;
}

Future<HomeBean> parseHomeBeanCompute(json) async {
  return compute(_parseHomeBean,json);
}

/// 加盟商城市列表
List<CorpGroupBean> _parseCorpListBean(dynamic json) {
  return (json['corp_group'] as List)
      ?.map((e) => e == null ? null : CorpGroupBean.fromJson(e))
      ?.toList();
}

Future<List<CorpGroupBean>> parseCorpListCompute(json) {
  return compute(_parseCorpListBean,json);
}

/// 加盟商信息
ConfigCorpBean _parseCorpInfoBean(dynamic json) {
  return ConfigCorpBean.fromJson(json);
}

Future<ConfigCorpBean> parseConfigCorpCompute(json) {
  return compute(_parseCorpInfoBean, json);
}


/// 文章列表
ArticleListBean _parseArticleListBean(dynamic json) {
  return ArticleListBean.fromJson(json);
}

Future<ArticleListBean> parseArticleListCompute(json) async {
  return compute(_parseArticleListBean,json);
}

///* 月嫂列表 */
YsListBean _parseYsList(dynamic json) {
  return YsListBean.fromJson(json);
}

Future<YsListBean> parseYsListCompute(json) async {
  return compute(_parseYsList, json);
}

///* 月嫂筛选 配置 */
ConfigYsWorkBean _parseYsConfig(dynamic value) {
  return ConfigYsWorkBean.fromJson(value);
}

Future<ConfigYsWorkBean> parseYsConfigCompute(json) {
  return compute(_parseYsConfig, json);
}

///* 月嫂详情 */
YsDetailBean _jsonParse(dynamic json) {
  return YsDetailBean.fromJson(json);
}
Future<YsDetailBean> parseYsDetailCompute(json) async {
  return compute(_jsonParse, json);
}

///* 月嫂评论 */
YsCommentList _parseYsCommentList(dynamic json) {
  return YsCommentList.fromJson(json);
}

Future<YsCommentList> parseYsCommentListCompute(json) async {
  return compute(_parseYsCommentList, json);
}

///* 工作风采列表 */
List<String> _parseWorkShowList(dynamic json) {
  return (json as List)
      ?.map(
          (e) => e == null || e['url'] == null ? null : e['url'].toString())
      ?.toList();
}
Future<List<String>> parseWorkShowListCompute(json) async {
  return compute(_parseWorkShowList, json);
}