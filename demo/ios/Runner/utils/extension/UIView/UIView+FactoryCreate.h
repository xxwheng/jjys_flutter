//
//  UIView+FactoryCreate.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 2017/1/11.
//  Copyright © 2017年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FactoryCreate)
/**  创建一个Label  */
- (UILabel *)titleLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat )font  textAlignment:(NSTextAlignment)textAlignment;

#pragma mark- 创建下划线
- (UIView *)createLineWithY:(CGFloat)orginY;

@end
