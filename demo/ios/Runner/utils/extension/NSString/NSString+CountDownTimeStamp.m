//
//  NSString+CountDownTimeStamp.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2016/10/13.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "NSString+CountDownTimeStamp.h"

@implementation NSString (CountDownTimeStamp)
+ (NSTimeInterval )timeStampCountDownWithCreatAtTimeStamp:(NSString *)timeStamp{
		//下单的2小时后减去当前时间
	NSString *create_at=[NSString stringWithFormat:@"%.0lf",timeStamp.doubleValue];
	NSTimeInterval twoHourAfter =[NSString stringWithFormat:@"%.0lf",create_at.doubleValue+(NSTimeInterval)60*60*2.0].doubleValue;
	NSTimeInterval currentTimeStamp =[NSDate date].timeIntervalSince1970;
	NSTimeInterval timeDiffer = twoHourAfter - currentTimeStamp;
	return timeDiffer;
}

@end
