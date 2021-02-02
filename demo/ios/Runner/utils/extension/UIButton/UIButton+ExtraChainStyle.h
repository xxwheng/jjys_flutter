//
//  UIButton+ExtraChainStyle.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2016/12/30.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ExtraChainStyle)

	/// 标题
- (UIButton *(^)(NSString *title, UIControlState state))titleWithState;
	/// 图片
- (UIButton *(^)(NSString *imgName, UIControlState state))imgageWithState;
	/// 标题颜色
- (UIButton *(^)(UIColor  *titleColor, UIControlState state))titleColorWithState;
	///背景色
- (UIButton *(^)(UIColor *bgColor))bgColor;
	///圆角
- (UIButton *(^)(CGFloat radius))cornerRadius;
	///边框
- (UIButton *(^)(CGFloat lineWidth,UIColor *lineColor))border;


@end
