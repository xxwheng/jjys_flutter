//
//  UIAlertView+BlockAction.m
//  UIAlertView的运行时拓展
//
//  Created by Wangguibin on 16/4/18.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "UIAlertView+BlockAction.h"

//#if TARGET_IPHONE_SIMULATOR
//#import <objc/objc-runtime.h>
//#else
//#import <objc/message.h>
//#endif
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

@implementation UIAlertView (BlockAction)

/**  setter方法 运行时设置关联对象block  */
-(void)setCallBackBlock:(CallBackBlock)callBackBlock
{
 objc_setAssociatedObject(self, @selector(callBackBlock), callBackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.delegate=self;
}

/** getter方法 捕获到这个关联对象  */
- (CallBackBlock)callBackBlock
{
    return objc_getAssociatedObject(self, @selector(callBackBlock));
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if (self.callBackBlock) {
        self.callBackBlock(alertView,buttonIndex);
    }
}

@end

#pragma clang diagnostic pop
