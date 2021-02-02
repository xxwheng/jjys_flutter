//
//  UIAlertView+BlockAction.h
//  UIAlertView的运行时拓展
//
//  Created by Wangguibin on 16/4/18.
//  Copyright © 2016年 王贵彬. All rights reserved.
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wdeprecated-declarations"
//
////写在这个中间的代码,都不会被编译器提示-Wdeprecated-declarations类型的警告
//#pragma clang diagnostic pop


#import <UIKit/UIKit.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

typedef void(^CallBackBlock)( UIAlertView* alertView,NSInteger index);

@interface UIAlertView (BlockAction)<UIAlertViewDelegate>


@property (nonatomic,copy) CallBackBlock callBackBlock;

@end
#pragma clang diagnostic pop