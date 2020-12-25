/// id : "87"
/// citycode : "103212"
/// name : "黄德梅"
/// level : "7"
/// desc : "1604期学员黄德梅综合能力非常强，从事母婴行业5年深得客户好评，专业技能扎实、是一位专业的母婴护理师。"
/// gender : "1"
/// province : "103198"
/// city : "103386"
/// area : "0"
/// is_credit : "1"
/// icon : "https://upload.jjys168.com/57555ac27e095.jpg"
/// proprietary : "0"
/// cityname : "深圳"

class YsMinBean {
  String _id;
  String _citycode;
  String _name;
  String _level;
  String _desc;
  String _gender;
  String _province;
  String _city;
  String _area;
  String _isCredit;
  String _icon;
  String _proprietary;
  String _cityname;

  String get id => _id;
  String get citycode => _citycode;
  String get name => _name;
  String get level => _level;
  String get desc => _desc;
  String get gender => _gender;
  String get province => _province;
  String get city => _city;
  String get area => _area;
  String get isCredit => _isCredit;
  String get icon => _icon;
  String get proprietary => _proprietary;
  String get cityname => _cityname;

  YsMinBean({
      String id, 
      String citycode, 
      String name, 
      String level, 
      String desc, 
      String gender, 
      String province, 
      String city, 
      String area, 
      String isCredit, 
      String icon, 
      String proprietary, 
      String cityname}){
    _id = id;
    _citycode = citycode;
    _name = name;
    _level = level;
    _desc = desc;
    _gender = gender;
    _province = province;
    _city = city;
    _area = area;
    _isCredit = isCredit;
    _icon = icon;
    _proprietary = proprietary;
    _cityname = cityname;
}

  YsMinBean.fromJson(dynamic json) {
    _id = json["id"];
    _citycode = json["citycode"];
    _name = json["name"];
    _level = json["level"];
    _desc = json["desc"];
    _gender = json["gender"];
    _province = json["province"];
    _city = json["city"];
    _area = json["area"];
    _isCredit = json["is_credit"];
    _icon = json["icon"];
    _proprietary = json["proprietary"];
    _cityname = json["cityname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["citycode"] = _citycode;
    map["name"] = _name;
    map["level"] = _level;
    map["desc"] = _desc;
    map["gender"] = _gender;
    map["province"] = _province;
    map["city"] = _city;
    map["area"] = _area;
    map["is_credit"] = _isCredit;
    map["icon"] = _icon;
    map["proprietary"] = _proprietary;
    map["cityname"] = _cityname;
    return map;
  }

}