//
//  NSString+MatchURL.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2017/3/30.
//  Copyright © 2017年 王贵彬. All rights reserved.
//

#import "NSString+MatchURL.h"

@implementation NSString (MatchURL)

//2017年3月30日 17:46:48
//用户同步授权
//app内嵌h5页面的时候在访问的时候带上user_id+token+citycode三个字段,注意不要重复出现问号(?)
//比如,
//
//引用地址:
//http://m.jjys168.com/html/index.html
//若链接无问号则带上?user_id=xxxx&token=xxx&citycode=xxx
//http://m.jjys168.com/html/index.html?user_id=xxxx&token=xxx&citycode=xxx
//
//引用地址:
//http://m.jjys168.com/index.php?
//若链接本身带有?号,所以,不能重复出现问号,所以,带上无问号部分user_id=xxxx&token=xxx&citycode=xxx
//http://m.jjys168.com/index.php?user_id=xxxx&token=xxx&citycode=xxx

- (NSString *)wgb_mapURL{
	NSString *user_id =[JJYSLoginTool getUid] ? : @"";
	NSString *token = [JJYSLoginTool getUser_token] ? : @"" ;
	NSString *citycode = [JJYSLoginTool defaultCityCode] ? : @"";
	NSString *cityName = [JJYSLoginTool cityName];
    NSString *corp_id = [JJYSLoginTool getCorpId];
	if ([self rangeOfString:@"?"].location == NSNotFound) {
			/// 不存在问号 + ? +&拼接
		NSString *truthURL = [NSString stringWithFormat:@"%@?user_id=%@&token=%@&citycode=%@&cityname=%@&platform=2&version=%@&_corp_id=%@",self,user_id,token,citycode,cityName,KVsionValue,corp_id];
		return  [truthURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	} else {///已存在问号+&拼接
		NSString *truthURL = [NSString stringWithFormat:@"%@&user_id=%@&token=%@&citycode=%@&cityname=%@&platform=2&version=%@&corp_id=%@",self,user_id,token,citycode,cityName,KVsionValue, corp_id];
		return  [truthURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	return nil;
}

- (NSString *)shopniu_mapURL {
	NSString *user_id =[JJYSLoginTool getShopniuId] ? : @"";//@"1280012800";
	NSString *token = [JJYSLoginTool getShopniuToken] ? : @"";//@"12345abc" ;
    NSString *corp_id = [JJYSLoginTool getCorpId];
	NSString *truthURL = @"";

	if ([self rangeOfString:@"?"].location == NSNotFound) {
			/// 不存在问号 + ? +&拼接
		truthURL = [NSString stringWithFormat:@"%@?user_id=%@&token=%@&is_insert=1&shop_id=29&_corp_id=%@",self,user_id,token, corp_id];
	} else {///已存在问号+&拼接
		truthURL = [NSString stringWithFormat:@"%@&user_id=%@&token=%@&is_insert=1&shop_id=29&_corp_id=%@",self,user_id,token, corp_id];
	}
	if ([user_id isEqualToString:@""]) {

		return [[NSString stringWithFormat:@"%@&logout=1&_corp_id=%@", truthURL, corp_id] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	return [truthURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark- 截取指定URL的指定参数....
+(NSString *)paramValueOfUrl:(NSString *) url withParam:(NSString *) param{
	NSError *error;
	NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive  error:&error];
		// 执行匹配的过程
	NSArray *matches = [regex matchesInString:url
									  options:0
										range:NSMakeRange(0, [url length])];
	for (NSTextCheckingResult *match in matches) {
		NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
		return tagValue;
	}
	return nil;
}

#pragma mark- 字典转URL参数
+ (NSString *)parametersStringWithDict:(NSDictionary *)parametersDict{
	NSArray *keys = parametersDict.allKeys;
	NSMutableString *param =[NSMutableString string];
	[keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger index, BOOL * _Nonnull stop) {
		if (index == 0) {
			[param appendFormat:@"%@=%@",key,parametersDict[key]];
		}else{
			[param appendFormat:@"&%@=%@",key,parametersDict[key]];
		}
	}];
	return param;
}



//+ (NSString *)hostBaseURLFromCityCode:(NSString *)citycode{
//		/// 深圳 103212  m.jjys168.com/api/   潮州 103395 cz.jjys168.com/api/
//	if ([citycode isEqualToString:@"103395"]) {
//		return  kChaoZhouHost;
//	}
//	return KServerHost;
//}



@end
