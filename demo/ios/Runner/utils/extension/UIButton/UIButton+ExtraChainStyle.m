//
//  UIButton+ExtraChainStyle.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2016/12/30.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "UIButton+ExtraChainStyle.h"

@implementation UIButton (ExtraChainStyle)

	/// 设置圆角
- (UIButton *(^)(CGFloat radius))cornerRadius{
	return ^(CGFloat radius){
		self.layer.cornerRadius = radius;
		self.layer.masksToBounds = YES;
		return self;
	};
}

	/// 设置边框
- (UIButton *(^)(CGFloat lineWidth,UIColor *lineColor))border{
	return ^(CGFloat lineWidth,UIColor *lineColor){
		self.layer.borderWidth = lineWidth;
		self.layer.borderColor = lineColor.CGColor;
		self.layer.masksToBounds = YES;
		return self;
	};
}

	///背景颜色
- (UIButton *(^)(UIColor *bgColor))bgColor{
	return  ^(UIColor *bgColor){
		self.backgroundColor = bgColor;
		return self;
	};
}

	/// 按钮标题与状态
- (UIButton *(^)(NSString *title, UIControlState state))titleWithState{
	return ^(NSString *title, UIControlState state){
		[self setTitle:title forState: state];
		return self;
	};
}

	/// 图片
- (UIButton *(^)(NSString *imgName, UIControlState state))imgageWithState{
	return ^(NSString *imgName, UIControlState state){
		[self setImage:[UIImage imageNamed:imgName] forState:state];
		return self;
	};
}

	/// 文字颜色与状态
- (UIButton *(^)(UIColor  *titleColor, UIControlState state))titleColorWithState{
	return ^(UIColor *titleColor, UIControlState state){
		[self setTitleColor: titleColor forState: state ];
		return self;
	};
}

@end
