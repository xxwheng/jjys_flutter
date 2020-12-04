/// 我的-个人信息
class UserInfoBean {
  String headPhoto;
  String id;
  String token;
  String nickName;
  int predictDay;
  int role;
  int status;

  UserInfoBean(this.headPhoto, this.id, this.nickName, this.predictDay, this.role, this.status, this.token);

  factory UserInfoBean.fromJson(Map<String,dynamic> json) {
    return UserInfoBean(json["headphoto"] as String,
        json["user_id"].toString(),
        json["nickname"] as String,
        int.parse(json["predict_day"].toString()),
        int.parse(json["role"].toString()),
        int.parse(json["status"].toString()),
        json["token"] as String);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "headphoto": this.headPhoto,
      "user_id": this.id,
      "nickname": this.nickName,
      "predict_day": this.predictDay,
      "role": this.role,
      "status": this.status,
      "token": this.token
    };
  }
}