import 'package:json_annotation/json_annotation.dart';

/* 月嫂列表 单项  */

class YsItemBean extends Object {
  int id;

  String level;

  String isCredit;

  String cityCode;

  String province;

  int scoreComment;

  int commentScore;

  String certificate;

  String birthday;

  String provinceName;

  String nickname;

  String headPhoto;

  String price;

  String desc;

  String service;

  String experience;

  String marketPrice;

  String careType;

  YsItemBean(
      this.id,
      this.level,
      this.isCredit,
      this.cityCode,
      this.province,
      this.scoreComment,
      this.commentScore,
      this.certificate,
      this.birthday,
      this.provinceName,
      this.nickname,
      this.headPhoto,
      this.desc,
      this.price,
      this.service,
      this.experience,
      this.marketPrice,
      this.careType);

  factory YsItemBean.fromJson(Map<String, dynamic> json) {
    return YsItemBean(
      int.parse(json['id'].toString()) ?? 0,
      json['level'].toString(),
      json['is_credit'].toString(),
      json['citycode'].toString(),
      json['province'].toString(),
      int.parse(json['score_comment'].toString()) ?? 0,
      int.parse(json['comment_score'].toString()) ?? 0,
      json['certificate'].toString(),
      json['birthday'].toString(),
      json['province_name'].toString(),
      json['nickname'].toString(),
      json['headphoto'].toString(),
      json['desc'].toString(),
      json['price'].toString(),
      json['service'].toString(),
      json['experience'].toString(),
      json['market_price'].toString(),
      json['care_type'].toString(),
    );
  }
}
