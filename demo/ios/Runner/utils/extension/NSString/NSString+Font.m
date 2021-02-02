//
//  NSString+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NSString+Font.h"

@implementation NSString (Font)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);

		// 获得系统版本
    if (IsIOS7) {
		return [self boundingRectWithSize:maxSize options:                      NSStringDrawingTruncatesLastVisibleLine |
				NSStringDrawingUsesLineFragmentOrigin |
				NSStringDrawingUsesFontLeading
                  attributes: attrs context:nil].size;
    } else {
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
