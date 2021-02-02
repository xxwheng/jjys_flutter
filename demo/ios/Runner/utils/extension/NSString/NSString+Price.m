//
//  NSString+Price.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2016/11/23.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "NSString+Price.h"

@implementation NSString (Price)

- (NSString *)priceTemplate{
	return  [NSString stringWithFormat:@"￥%@元",self];
}

- (NSString *)subPriceTemplate{
	return  [NSString stringWithFormat:@"-￥%@元",self];
}

@end
