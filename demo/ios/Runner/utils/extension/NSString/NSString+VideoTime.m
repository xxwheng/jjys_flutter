//
//  NSString+VideoTime.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 16/8/3.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "NSString+VideoTime.h"

@implementation NSString (VideoTime)
+ (NSString *)stringWithTime:(NSTimeInterval)time {

    NSInteger min = time / 60;
    NSInteger second = (NSInteger)time % 60;

    return [NSString stringWithFormat:@"%02ld'%02ld\"", min, second];
}

@end
