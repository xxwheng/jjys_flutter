//
//  UIView+FactoryCreate.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2017/1/11.
//  Copyright © 2017年 王贵彬. All rights reserved.
//

#import "UIView+FactoryCreate.h"

@implementation UIView (FactoryCreate)

- (UILabel *)titleLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat )font  textAlignment:(NSTextAlignment)textAlignment
{
	UILabel *titleLabel = [UILabel new];
	titleLabel.text = text;
	titleLabel.textColor = textColor;
	titleLabel.font = KSetFontSize(font);
	titleLabel.textAlignment = textAlignment;
	return titleLabel;
}

#pragma mark- 创建下划线
- (UIView *)createLineWithY:(CGFloat)orginY{
	UIView *line =[[UIView alloc] initWithFrame:CGRectMake(0, orginY, KWIDTH , 1)];
	line.backgroundColor = [UIColor groupTableViewBackgroundColor];
	return  line;
}

@end
