//
//  HolidayFeeAlertView.m
//  WGBAlertView
//
//  Created by Wangguibin on 16/9/29.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "HolidayFeeAlertView.h"

@implementation HolidayFeeAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self setup];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds =YES;
    }
    return self;
}


- (void)setup{

    UIImageView *iconView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suprise"]];
    iconView.center =CGPointMake(self.center.x, self.center.y/3);
    [self addSubview: iconView];

    CGFloat labelX =15;
    CGFloat labelY = CGRectGetMaxY(iconView.frame)+5;
    CGFloat labelW = self.bounds.size.width-30;
    CGFloat labelH = 100;
    UILabel *contentLabel =[[UILabel alloc] init];
    contentLabel.frame = CGRectMake(labelX, labelY, labelW , labelH);
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1.00];
    contentLabel.text =@"如果您选择不支付节假日额外费用,月嫂将按实际节日天数提前结束服务。";
    [self addSubview: contentLabel];

    UIButton *confirmButton =[UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame =CGRectMake(0, CGRectGetMaxY(contentLabel.frame)+5, labelW , 30);
    confirmButton.center=CGPointMake(self.center.x, confirmButton.center.y);
    confirmButton.backgroundColor =[UIColor colorWithRed:0.54 green:0.27 blue:0.75 alpha:1.00];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(clickButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: confirmButton];

}

- (void)clickButtonAction{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}



@end
