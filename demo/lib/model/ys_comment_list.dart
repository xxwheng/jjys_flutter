import 'package:date_format/date_format.dart';
import 'package:demo/model/xx_int_title.dart';

class YsCommentList {
  int count;
  int page;
  int size;
  int total;
  YsScore score;
  List<YsCommentItem> data;

  YsCommentList(
      this.count, this.page, this.size, this.total, this.score, this.data);

  factory YsCommentList.fromJson(Map<String, dynamic> json) {
    return YsCommentList(
        int.parse(json['count'].toString()),
        int.parse(json['page'].toString()),
        int.parse(json['size'].toString()),
        int.parse(json['total'].toString()),
        YsScore.fromJson(json['score']),
        (json['data'] as List)
            ?.map((e) => e == null ? null : YsCommentItem.fromJson(e))
            ?.toList());
  }
}

class YsCommentItem {
  String adminId;
  String cityCode;
  String commentId;
  String detail;
  String headPhoto;
  String id;
  List<String> image;
  String isMock;
  String nickname;
  String orderId;
  String productDays;
  String role;
  double score;
  String status;
  int time;
  String timeStr;
  String top;
  String updateAt;
  String userId;
  String username;
  String yuesaoId;

  YsCommentItem(
      this.adminId,
      this.cityCode,
      this.commentId,
      this.detail,
      this.headPhoto,
      this.id,
      this.image,
      this.isMock,
      this.nickname,
      this.orderId,
      this.productDays,
      this.role,
      this.score,
      this.status,
      this.time,
      this.top,
      this.updateAt,
      this.userId,
      this.username,
      this.yuesaoId);

  factory YsCommentItem.fromJson(Map<String, dynamic> json) {
    YsCommentItem item = YsCommentItem(
      json['admin_id'].toString(),
      json['citycode'].toString(),
      json['comment_id'].toString(),
      json['detail'].toString(),
      json['headphoto'].toString(),
      json['id'].toString(),
      (json['image'] as List)
          ?.map((e) => null == e ? null : e.toString())
          ?.toList(),
      json['is_mock'].toString(),
      json['nickname'].toString(),
      json['order_id'].toString(),
      json['product_days'].toString(),
      json['role'].toString(),
      double.parse(json['score'].toString()) ?? 0,
      json['status'].toString(),
      int.parse(json['time'].toString()) ?? 0,
      json['top'].toString(),
      json['update_at'].toString(),
      json['user_id'].toString(),
      json['username'].toString(),
      json['yuesao_id'].toString(),
    );

    var date = DateTime.fromMillisecondsSinceEpoch(item.time * 1000);
    var str = formatDate(date, [yyyy, '-', mm, '-', dd]);
    item.timeStr = str;
    return item;
  }
}

class YsScore {
  double scoreAvg;

//月嫂  ["宝宝护理", "宝宝早教", "膳食搭配", "科学素养", "产妇护理", "沟通技巧"]
  List<XXDoubleTitleBean> ysScoreList;
  YsScoreDetail scoreDetail;

  YsScore(this.scoreAvg, this.scoreDetail);

  factory YsScore.fromJson(Map<String, dynamic> json) {
    YsScore item = YsScore(double.parse(json['score_avg'].toString()) ?? 0,
        YsScoreDetail.fromJson(json['score_detail']));
    item.ysScoreList = [
      XXDoubleTitleBean(item.scoreDetail.nurse, "宝宝护理"),
      XXDoubleTitleBean(item.scoreDetail.education, "宝宝早教"),
      XXDoubleTitleBean(item.scoreDetail.diet, "膳食搭配"),
      XXDoubleTitleBean(item.scoreDetail.advice, "科学素养"),
      XXDoubleTitleBean(item.scoreDetail.patience, "产妇护理"),
      XXDoubleTitleBean(item.scoreDetail.communication, "沟通技巧")
    ];
    return item;
  }
}

class YsScoreDetail {
  double advice;
  double communication;
  double diet;
  double education;
  double nurse;
  double patience;

  YsScoreDetail(this.advice, this.communication, this.diet, this.education,
      this.nurse, this.patience);

  factory YsScoreDetail.fromJson(Map<String, dynamic> json) {
    return YsScoreDetail(
        double.parse(json['advice'].toString()) ?? 0,
        double.parse(json['communication'].toString()) ?? 0,
        double.parse(json['diet'].toString()) ?? 0,
        double.parse(json['education'].toString()) ?? 0,
        double.parse(json['nurse'].toString()) ?? 0,
        double.parse(json['patience'].toString()) ?? 0);
  }
}
