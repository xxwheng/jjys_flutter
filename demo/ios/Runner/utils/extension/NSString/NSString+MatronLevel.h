//
//  NSString+MatronLevel.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2016/11/24.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MatronLevel)

	///月嫂等级映射中文
- (NSString *)matronLevel ;
	///月嫂等级图片
- (UIImage *)levelLabelImage;

/// 月嫂等级文字
- (NSString *)levelLabelText;

/// 育婴师等级文字
- (NSString *)yuYingLevelLabelText: (NSString *)careType;

	///月嫂等级星星图片
- (UIImage *)levelStarImage;
	/// 育婴师等级映射中文
- (NSString *)yuYingLevel;
	///育婴师等级图片
- (UIImage *)yuYingLabelImage;
	///育婴师星级
- (UIImage *)yuYingStarImage;

@end
