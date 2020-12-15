
import 'package:demo/network/dio/http_config.dart';
import 'package:logger/logger.dart';

var logger = Logger();

/* 登录 注册协议 */
final String kUrlRegisterProtocol = HttpConfig.webUrl + "/html/registerProtocol.html";

/* 优惠券使用规则 */
final String kUrlCouponRule = HttpConfig.webUrl + "/html/coupon_rule.html";

/* 月嫂认证信息 网页 */
final String kAuthInfoYueSao = HttpConfig.webUrl + "/html/approveinfo.html?yuesao_id=";

/* 月嫂服务内容 */
final String kYueSaoServiceInfo = HttpConfig.webUrl + "/html/serviceinfo.html?level=";