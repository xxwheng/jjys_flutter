/* !:
 * @FileName(文件名):  XXBaseViewController.h
 * @ProjectName(工程名):   JJYSPlus
 * @CreateDate(创建日期):  Created by Wangguibin on 16/5/20.
 * @Copyright(版权所有) :   Copyright © 2016年 王贵彬. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface XXBaseViewController : UIViewController

/**
 *  返回按钮的title; 防止title 过长引起的下一页面的title 不居中问题
 */
@property (nonatomic, copy) NSString *backTitle;

#pragma mark- 回到上一个控制器
- (void)goBackWithAnimated:(BOOL)animated ;
#pragma mark- 后退多少步
/**
 *  回退几步
 *
 *  @param step     步数
 *  @param animated 是否显示动画
 */
- (void)goBackByBackStep:(NSInteger)step animated:(BOOL)animated ;
#pragma mark- 添加导航栏右侧的按钮
- (void)setRightItemButtons:(NSArray *)buttons;
#pragma mark-返回导航视图
-(void)popRootViewController;
#pragma mark- 设置导航栏标题以及一些基础设置
- (void)setupBasicSettingsWithNavBarTitle:(NSString *)text;

@end
