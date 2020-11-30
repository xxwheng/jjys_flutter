
// 加盟商分组列表
class CorpGroupBean {
  String city;
  String sortBy;
  String cityCode;
  bool isExpanded = false;
  List<CorpCityBean> list;

  CorpGroupBean(this.city, this.sortBy, this.cityCode, this.list);

  factory CorpGroupBean.fromJson(Map<String, dynamic> json) {
    return CorpGroupBean(json["city"].toString(), json["sort_by"].toString(),
        json["citycode"].toString(), (json["list"] as List)?.map((e) => e==null ? null : CorpCityBean.fromJson(e))?.toList());
  }
}

class CorpCityBean {
  String id;
  String title;
  String city;
  String titleJiaJia;
  String cityCode;
  String sortBy;

  CorpCityBean(this.id, this.title, this.city, this.titleJiaJia, this.cityCode, this.sortBy);

  factory CorpCityBean.fromJson(Map<String, dynamic> json) {
    return CorpCityBean(json["id"].toString(), json["title"].toString(),
        json["city"].toString(), json["title_jiajia"].toString(),
        json["citycode"].toString(), json["sort_by"].toString());
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'title': this.title,
      'city': this.city,
      'title_jiajia': this.titleJiaJia,
      'citycode': this.cityCode,
      'sort_by': this.sortBy,
    };
  }
}