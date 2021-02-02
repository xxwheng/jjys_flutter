//
//  NSString+Replace.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2017/3/22.
//  Copyright © 2017年 王贵彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Replace)

	/// 某个范围内 用某个字符串替换
- (NSString *)replaceStringWithRange:(NSRange)range charsetString:(NSString *)charset;

	///把尾部替换掉
- (NSString *)replaceRumpStringWithString:(NSString *)str ;

	///把中部替换掉 类似手机号码 135 XXXX 5320
- (NSString *)replaceMiddlePartStringWithString:(NSString *)str ;

	///把头部替换掉
- (NSString *)replaceHeaderStringWithString:(NSString *)str ;



@end
