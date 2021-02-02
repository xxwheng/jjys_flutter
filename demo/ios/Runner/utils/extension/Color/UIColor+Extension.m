//
//  UIColor+Extension.m
//  JJYSPlusPlus
//
//  Created by wheng on 2019/2/15.
//  Copyright © 2019年 王恒. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)initHex:(int)hex {
	return  [self initHex:hex alpha:1.0];
}

+ (UIColor *)initHex:(int)hex alpha:(CGFloat)alpha {
	return [UIColor
			colorWithRed:[self transform:hex offset:16]
			green:[self transform:hex offset:8]
			blue:[self transform:hex offset:0]
			alpha:alpha];
}

+ (CGFloat)transform:(int)input offset:(int)offset {
	int value = (input >> offset) & 0xff;
	return (CGFloat)value / 255;
}


@end
