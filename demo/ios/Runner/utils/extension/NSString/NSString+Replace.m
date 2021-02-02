//
//  NSString+Replace.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2017/3/22.
//  Copyright © 2017年 王贵彬. All rights reserved.
//

#import "NSString+Replace.h"

@implementation NSString (Replace)

	/// 某个范围内 用某种字符串替换
- (NSString *)replaceStringWithRange:(NSRange)range charsetString:(NSString *)charset{
	if (self.length == 0) {
		return nil;
	}
	return [self stringByReplacingCharactersInRange: range  withString: charset];
}
	///把尾部替换掉
- (NSString *)replaceRumpStringWithString:(NSString *)str {

	return [self replaceStringWithRange:NSMakeRange(self.length - str.length, str.length) charsetString: str];
}

	///把中部替换掉 类似手机号码 135 XXXX 5320
- (NSString *)replaceMiddlePartStringWithString:(NSString *)str {
	NSRange range = NSMakeRange((self.length - str.length)/2.0 , str.length);
	return [self replaceStringWithRange: range charsetString: str];
}

	///把头部替换掉
- (NSString *)replaceHeaderStringWithString:(NSString *)str {
	return [self replaceStringWithRange:NSMakeRange(0, str.length) charsetString:str];
}

@end
