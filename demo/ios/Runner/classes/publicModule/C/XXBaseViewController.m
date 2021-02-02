/* !:
 * @FileName(文件名):  XXBaseViewController.m
 * @ProjectName(工程名):   JJYSPlus
 * @CreateDate(创建日期):  Created by Wangguibin on 16/5/20.
 * @Copyright(版权所有) :   Copyright © 2016年 王贵彬. All rights reserved.
 */


#import "XXBaseViewController.h"


@interface XXBaseViewController ()

@property (nonatomic,assign) CGFloat historyY;


@end

@implementation XXBaseViewController


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
//  [self checkNetworkStatus_AFN];

}




#pragma mark- AFN检测网络状态
- (void)checkNetworkStatus_AFN{
	[[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		if(kNetworkNotReachability){
		  [SVProgressHUD showInfoWithStatus:@"没网了😯word哥 ~"];
		}

		switch (status) {
			case AFNetworkReachabilityStatusNotReachable:{

				NSLog(@"无网络");
				break;
			}
			case AFNetworkReachabilityStatusReachableViaWiFi:{
				NSLog(@"WiFi网络");
//				[SVProgressHUD showInfoWithStatus:@"当前的网络为WIFI~"];

				break;
			}
			case AFNetworkReachabilityStatusReachableViaWWAN:{

				NSLog(@"无线网络");
//				[SVProgressHUD showInfoWithStatus:@"当前的网络为2G/3G/4G蜂窝网络"];

				break;
			}
			default:
				break;
		}
	}];

}



#pragma mark- 设置返回按钮的标题
- (void)setBackTitle:(NSString *)backTitle {
    _backTitle = backTitle;
    if (self.navigationItem) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_backTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    }
}

#pragma mark- 后退多少步
/**
 *  回退几步
 *
 *  @param step     步数
 *  @param animated 是否显示动画
 */
- (void)goBackByBackStep:(NSInteger)step animated:(BOOL)animated{

    if (step == 0) {
        return;
    }
    if (step == 1) {
        [self goBackWithAnimated:animated];
        return;
    }
    NSArray *viewControllers = [self.navigationController viewControllers];
    if (step >=viewControllers.count) {
        [self.navigationController popToRootViewControllerAnimated:animated];
        return;
    }
    UIViewController *toController = viewControllers[viewControllers.count-step-1];
    [self.navigationController popToViewController:toController animated:animated];
}

#pragma mark- 回到上一个控制器
- (void)goBackWithAnimated:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
}

#pragma mark- 设置导航栏标题以及一些基础设置
- (void)setupBasicSettingsWithNavBarTitle:(NSString *)text{
    self.navigationItem.title = text;
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,KSetFontSize(20),NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributes];
}

#pragma mark- 添加导航栏右侧的按钮
- (void)setRightItemButtons:(NSArray *)buttons{
    NSMutableArray *itemButtons = [NSMutableArray array];
    [buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarButtonItem *itemButton = [[UIBarButtonItem alloc]initWithCustomView:button];
        [itemButtons addObject:itemButton];
    }];
    self.navigationItem.rightBarButtonItems = itemButtons;
}

#pragma mark-返回导航视图
-(void)popRootViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
