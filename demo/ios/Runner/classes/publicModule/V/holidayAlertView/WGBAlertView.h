//
//  WGBAlertView.h
//  WGBAlertView
//
//  Created by Wangguibin on 16/9/18.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGBAlertView;

@protocol WGBAlertViewDelegate <NSObject>

@optional
- (void)alertView:(WGBAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end


@interface WGBAlertView : UIView

@property (strong, nonatomic) UIView *contentView;
@property (nonatomic,assign) CGFloat centerOffset;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (nonatomic,assign) BOOL  touchBgDismiss; //点击蒙版消除
@property (weak, nonatomic) id<WGBAlertViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message delegate:(id<WGBAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)show;

- (void)hide;

// Set the color and font size of title, if color is nil, default is black. if fontsize is 0, default is 14
//设置标题的字体和颜色
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

// Set the color and font size of message, if color is nil, default is black. if fontsize is 0, default is 12
//设置信息字体和颜色
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;

// Set the color and font size of button at the index, if color is nil, default is black. if fontsize is 0, default is 16
//设置按钮文字字体和颜色
- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;
//设置按钮背景色
- (void)setButtonBackgroundColor:(UIColor *)color  atIndex:(NSInteger)index ;

@end
