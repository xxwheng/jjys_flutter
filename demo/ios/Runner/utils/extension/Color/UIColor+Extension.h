//
//  UIColor+Extension.h
//  JJYSPlusPlus
//
//  Created by wheng on 2019/2/15.
//  Copyright © 2019年 王恒. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Extension)

/**
 16进制转Color

 @param hex 16进制
 @return UIColor
 */
+ (UIColor *)initHex:(int)hex;

/// alpha 透明度
+ (UIColor *)initHex:(int)hex alpha:(CGFloat)alpha;

@end

