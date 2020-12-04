
/* 网页链接桥接层
*
* 添加一些公共的参数
*
*  */
import 'package:demo/data/corp_data.dart';
import 'package:demo/model/corp_grop_bean.dart';
import 'package:demo/network/dio/http_config.dart';

/* 网址中间层 加一些公共参数 */
class WebUrlBridge {
  static Future<String> urlBridget(String url) async {
    var nextUrl = url;
    if (url.contains("?")) {
      /// 有参数
      nextUrl = nextUrl + "&";
    } else {
      /// 无参数
      nextUrl = nextUrl + "?";
    }

    CorpCityBean _corp = await CorpData().getCorpDataFromCache();
    nextUrl += "citycode=${_corp.cityCode}&cityname=${_corp.city}&_corp_id=${_corp.id}&platform=2&version=${HttpConfig.version}";
    return Uri.encodeFull(nextUrl);
  }
}