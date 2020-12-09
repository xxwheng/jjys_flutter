
class YsCommentList {
  int count;
  int page;
  int size;
  int total;
  YsScore score;
  List<YsCommentItem> data;

  YsCommentList(this.count, this.page, this.size, this.total, this.score, this.data);

  factory YsCommentList.fromJson(Map<String, dynamic> json) {
    return YsCommentList(
        int.parse(json['count'].toString()),
        int.parse(json['page'].toString()),
        int.parse(json['size'].toString()),
        int.parse(json['total'].toString()),
        YsScore.fromJson(json['score']),
        (json['data'] as List)?.map((e) => e==null?null:YsCommentItem.fromJson(e))?.toList()
    );
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
  int score;
  String status;
  int time;
  String top;
  String updateAt;
  String userId;
  String username;
  String yuesaoId;

  YsCommentItem(this.adminId, this.cityCode, this.commentId, this.detail,
      this.headPhoto, this.id, this.image, this.isMock, this.nickname,
      this.orderId, this.productDays, this.role, this.score, this.status,
      this.time, this.top, this.updateAt, this.userId, this.username, this.yuesaoId);

  factory YsCommentItem.fromJson(Map<String, dynamic> json) {
    return YsCommentItem(
      json['admin_id'].toString(),
      json['citycode'].toString(),
      json['comment_id'].toString(),
      json['detail'].toString(),
      json['headphoto'].toString(),
      json['id'].toString(),
        (json['image'] as List)?.map((e) => null==e?null:e.toString())?.toList(),
      json['is_mock'].toString(),
      json['nickname'].toString(),
      json['order_id'].toString(),
      json['product_days'].toString(),
      json['role'].toString(),
      int.parse(json['score'].toString()) ?? 0,
      json['status'].toString(),
      int.parse(json['time'].toString()) ?? 0,
      json['top'].toString(),
      json['update_at'].toString(),
      json['user_id'].toString(),
      json['username'].toString(),
      json['yuesao_id'].toString(),
    );
  }
}

class YsScore {
  int scoreAvg;
  YsScoreDetail scoreDetail;
  
  YsScore(this.scoreAvg, this.scoreDetail);
  
  factory YsScore.fromJson(Map<String, dynamic> json) {
    return YsScore(json['score_avg'] as int, YsScoreDetail.fromJson(json['score_detail']));
  }
}

class YsScoreDetail {
  int advice;
  int communication;
  int diet;
  int education;
  int nurse;
  int patience;
  
  YsScoreDetail(this.advice, this.communication, this.diet, this.education, this.nurse, this.patience);
  
  factory YsScoreDetail.fromJson(Map<String, dynamic> json) {
    return YsScoreDetail(
        json['advice'] as int,
        json['communication'] as int,
        json['diet'] as int,
        json['education'] as int,
        json['nurse'] as int,
        json['patience'] as int
    );
  }
}