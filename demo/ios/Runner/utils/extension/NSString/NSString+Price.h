//
//  NSString+Price.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2016/11/23.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Price)

/// 拼成 "￥100元"
- (NSString *)priceTemplate;
	/// 拼成 "-￥100元"
- (NSString *)subPriceTemplate;

@end
