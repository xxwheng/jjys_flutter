

import 'package:flutter/foundation.dart';

/// 文章分类 模型
class ArticleCategoryBean {
  String id;
  String title;
  String listNo;
  String createAt;

  ArticleCategoryBean(this.id, this.title, this.listNo, this.createAt);

  factory ArticleCategoryBean.fromJson(Map<String, dynamic> json) {
    return ArticleCategoryBean(json["id"].toString(), json["title"].toString(), json["list_no"].toString(), json["create_at"].toString());
  }
}

/// 文章列表
class ArticleListBean {
  int page;
  int total;
  List<ArticleBean> list;

  ArticleListBean(this.page, this.total, this.list);

  factory ArticleListBean.fromJson(Map<String, dynamic> json) {
    return ArticleListBean(
        int.parse(json['page'].toString()),
        int.parse(json['total'].toString()),
        (json['data'] as List)
            ?.map((e) => e == null ? null : ArticleBean.fromJson(e))
            ?.toList()
    );
  }
}

/// 文章 模型
class ArticleBean {
  String id;
  String categoryId;
  String keyword;
  String title;
  String image;
  String desc;
  String createAt;
  String link;
  String categoryName;
  
  ArticleBean(this.id, this.categoryId, this.keyword, this.title, this.image, this.desc, this.createAt, this.link, this.categoryName);

  factory ArticleBean.fromJson(Map<String, dynamic> json) {
    return ArticleBean(
        json["id"].toString(),
        json["category_id"].toString(),
        json["keyword"].toString(),
        json["title"].toString(),
        json["image"].toString(),
        json["desp"].toString(),
        json["create_at"].toString(),
        json["link"].toString(),
        json["category_name"].toString()
    );
  }

}