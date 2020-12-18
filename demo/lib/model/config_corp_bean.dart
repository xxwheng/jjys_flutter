/// title : "深圳家家母婴科技有限公司"
/// title_jiajia : "深圳"
/// citycode : "103212"
/// chat_link : ""
/// corp_id : "1"
/// logo_width : "http://upload.jjys168.com//jiajiamuying_upload/20190709/15626675975d246a4d52fa4.png"
/// contact : "18038155413"
/// contact_xue : "13360517359"
/// pic_address : "http://upload.ddys168.com//jiajiamuying_upload/20181108/15416414555be394efca810.png"
/// address : "深圳市深南中路3024号航空大厦33层"
/// host_user : "jjys168.com"
/// weixin_mp : "http://upload.ddys168.com//jiajiamuying_upload/20181108/15416415235be395333185a.jpg"
/// awt_kefu : "https://AWT.zoosnet.net/LR/Chatpre.aspx?id=AWT48536194&cid=&lng=cn&sid=&p="
/// beian : "粤ICP备15110158号"
/// html_inject : "<script>\r\nvar _hmt = _hmt || [];\r\n(function() {\r\n  var hm = document.createElement(\"script\");\r\n  hm.src = \"https://hm.baidu.com/hm.js?5549986d7d116832f5c81d5e0ffafec9\";\r\n  var s = document.getElementsByTagName(\"script\")[0]; \r\n  s.parentNode.insertBefore(hm, s);\r\n})();\r\n</script>"
/// seo_title : ""
/// seo_keyword : ""
/// seo_desp : ""
/// title_min : "深圳"
/// awt_kefu_id : "AWT48536194"
/// awt_zhaoshen_id : "LZT51573891"
/// awt_js_kefu : "<script language=\"javascript\" src=\"https://AWT.zoosnet.net/JS/LsJS.aspx?siteid=AWT48536194&float=1&lng=cn\"></script>"
/// awt_zhanshen : "https://LZT.zoosnet.net/LR/Chatpre.aspx?id=LZT51573891&cid=&lng=cn&sid=&p="
/// awt_js_zhanshen : "<script language=\"javascript\" src=\"https://LZT.zoosnet.net/JS/LsJS.aspx?siteid=LZT51573891&float=1&lng=cn\"></script>"
/// baidu_ad : 0
/// company : "深圳家家母婴科技有限公司"
/// geoaddr : ["22.541089","114.082682"]
/// vip_level : 0

class ConfigCorpBean {
  String _title;
  String _titleJiajia;
  String _citycode;
  String _chatLink;
  String _corpId;
  String _logoWidth;
  String _contact;
  String _contactXue;
  String _picAddress;
  String _address;
  String _hostUser;
  String _weixinMp;
  String _awtKefu;
  String _beian;
  String _htmlInject;
  String _seoTitle;
  String _seoKeyword;
  String _seoDesp;
  String _titleMin;
  String _awtKefuId;
  String _awtZhaoshenId;
  String _awtJsKefu;
  String _awtZhanshen;
  String _awtJsZhanshen;
  int _baiduAd;
  String _company;
  List<String> _geoaddr;
  int _vipLevel;

  String get title => _title;
  String get titleJiajia => _titleJiajia;
  String get citycode => _citycode;
  String get chatLink => _chatLink;
  String get corpId => _corpId;
  String get logoWidth => _logoWidth;
  String get contact => _contact;
  String get contactXue => _contactXue;
  String get picAddress => _picAddress;
  String get address => _address;
  String get hostUser => _hostUser;
  String get weixinMp => _weixinMp;
  String get awtKefu => _awtKefu;
  String get beian => _beian;
  String get htmlInject => _htmlInject;
  String get seoTitle => _seoTitle;
  String get seoKeyword => _seoKeyword;
  String get seoDesp => _seoDesp;
  String get titleMin => _titleMin;
  String get awtKefuId => _awtKefuId;
  String get awtZhaoshenId => _awtZhaoshenId;
  String get awtJsKefu => _awtJsKefu;
  String get awtZhanshen => _awtZhanshen;
  String get awtJsZhanshen => _awtJsZhanshen;
  int get baiduAd => _baiduAd;
  String get company => _company;
  List<String> get geoaddr => _geoaddr;
  int get vipLevel => _vipLevel;

  ConfigCorpBean({
      String title, 
      String titleJiajia, 
      String citycode, 
      String chatLink, 
      String corpId, 
      String logoWidth, 
      String contact, 
      String contactXue, 
      String picAddress, 
      String address, 
      String hostUser, 
      String weixinMp, 
      String awtKefu, 
      String beian, 
      String htmlInject, 
      String seoTitle, 
      String seoKeyword, 
      String seoDesp, 
      String titleMin, 
      String awtKefuId, 
      String awtZhaoshenId, 
      String awtJsKefu, 
      String awtZhanshen, 
      String awtJsZhanshen, 
      int baiduAd, 
      String company, 
      List<String> geoaddr, 
      int vipLevel}){
    _title = title;
    _titleJiajia = titleJiajia;
    _citycode = citycode;
    _chatLink = chatLink;
    _corpId = corpId;
    _logoWidth = logoWidth;
    _contact = contact;
    _contactXue = contactXue;
    _picAddress = picAddress;
    _address = address;
    _hostUser = hostUser;
    _weixinMp = weixinMp;
    _awtKefu = awtKefu;
    _beian = beian;
    _htmlInject = htmlInject;
    _seoTitle = seoTitle;
    _seoKeyword = seoKeyword;
    _seoDesp = seoDesp;
    _titleMin = titleMin;
    _awtKefuId = awtKefuId;
    _awtZhaoshenId = awtZhaoshenId;
    _awtJsKefu = awtJsKefu;
    _awtZhanshen = awtZhanshen;
    _awtJsZhanshen = awtJsZhanshen;
    _baiduAd = baiduAd;
    _company = company;
    _geoaddr = geoaddr;
    _vipLevel = vipLevel;
}

  ConfigCorpBean.fromJson(dynamic json) {
    _title = json["title"];
    _titleJiajia = json["title_jiajia"];
    _citycode = json["citycode"];
    _chatLink = json["chat_link"];
    _corpId = json["corp_id"];
    _logoWidth = json["logo_width"];
    _contact = json["contact"];
    _contactXue = json["contact_xue"];
    _picAddress = json["pic_address"];
    _address = json["address"];
    _hostUser = json["host_user"];
    _weixinMp = json["weixin_mp"];
    _awtKefu = json["awt_kefu"];
    _beian = json["beian"];
    _htmlInject = json["html_inject"];
    _seoTitle = json["seo_title"];
    _seoKeyword = json["seo_keyword"];
    _seoDesp = json["seo_desp"];
    _titleMin = json["title_min"];
    _awtKefuId = json["awt_kefu_id"];
    _awtZhaoshenId = json["awt_zhaoshen_id"];
    _awtJsKefu = json["awt_js_kefu"];
    _awtZhanshen = json["awt_zhanshen"];
    _awtJsZhanshen = json["awt_js_zhanshen"];
    _baiduAd = json["baidu_ad"];
    _company = json["company"];
    _geoaddr = json["geoaddr"] != null ? json["geoaddr"].cast<String>() : [];
    _vipLevel = json["vip_level"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["title_jiajia"] = _titleJiajia;
    map["citycode"] = _citycode;
    map["chat_link"] = _chatLink;
    map["corp_id"] = _corpId;
    map["logo_width"] = _logoWidth;
    map["contact"] = _contact;
    map["contact_xue"] = _contactXue;
    map["pic_address"] = _picAddress;
    map["address"] = _address;
    map["host_user"] = _hostUser;
    map["weixin_mp"] = _weixinMp;
    map["awt_kefu"] = _awtKefu;
    map["beian"] = _beian;
    map["html_inject"] = _htmlInject;
    map["seo_title"] = _seoTitle;
    map["seo_keyword"] = _seoKeyword;
    map["seo_desp"] = _seoDesp;
    map["title_min"] = _titleMin;
    map["awt_kefu_id"] = _awtKefuId;
    map["awt_zhaoshen_id"] = _awtZhaoshenId;
    map["awt_js_kefu"] = _awtJsKefu;
    map["awt_zhanshen"] = _awtZhanshen;
    map["awt_js_zhanshen"] = _awtJsZhanshen;
    map["baidu_ad"] = _baiduAd;
    map["company"] = _company;
    map["geoaddr"] = _geoaddr;
    map["vip_level"] = _vipLevel;
    return map;
  }

}