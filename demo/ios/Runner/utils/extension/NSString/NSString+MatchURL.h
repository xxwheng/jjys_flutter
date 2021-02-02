//
//  NSString+MatchURL.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2017/3/30.
//  Copyright © 2017年 王贵彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MatchURL)

	//// URL拼接参数
- (NSString *)wgb_mapURL;

- (NSString *)shopniu_mapURL;

#pragma mark- 截取指定URL的指定参数....
+ (NSString *) paramValueOfUrl:(NSString *) url withParam:(NSString *) param;

#pragma mark- 字典转URL参数
+(NSString *)parametersStringWithDict:(NSDictionary *)parametersDict;

	///通过citycode 返回切换域名
+ (NSString *)hostBaseURLFromCityCode:(NSString *)citycode ;


@end
