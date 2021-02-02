//
//  Nav.m
//  CustomPopAnimation
//
//  Created by Jazys on 15/3/30.
//  Copyright (c) 2015年 Jazys. All rights reserved.
//

#import "CustomNavigationController.h"
#import "NavigationInteractiveTransition.h"

@interface CustomNavigationController () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;
@end


@implementation CustomNavigationController
{
	BOOL __shouldAutorotate;
}


+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundColor:KNavColor];
    [bar setTintColor:KNavColor];
    [bar setBarTintColor:KNavColor];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]}];
    // 设置item
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    [item setTintColor: JJBlackColor];
//    // UIControlStateNormal
//    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
//    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
//    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
//    // UIControlStateDisabled
//    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
//    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.navigationBar.hidden=YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//	[self addCustomPanGesturePopVC];

		//注册旋转屏幕的通知
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(autorotateInterface:) name:@"InterfaceOrientation" object:nil];
}


- (void)addCustomPanGesturePopVC{

	UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
	gesture.enabled = NO;
	UIView *gestureView = gesture.view;

	UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
	popRecognizer.delegate = self;
	popRecognizer.maximumNumberOfTouches = 1;
	[gestureView addGestureRecognizer:popRecognizer];


		//#if USE_方案一
		//    _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
		//    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
		//
		//#elif USE_方案二
	/**
	 *  获取系统手势的target数组
	 */
	NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
	/**
	 *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
	 */
	id gestureRecognizerTarget = [_targets firstObject];
	/**
	 *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
	 */
	id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
	/**
	 *  通过前面的打印，我们从控制台获取出来它的方法签名。
	 */
	SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
	/**
	 *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
	 */
	[popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
		//#endif
}

-(void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)autorotateInterface:(NSNotification *)notifition
{

	__shouldAutorotate = [notifition.object boolValue];
	NSLog(@"接收到的通知>> %d", __shouldAutorotate);
}

/**
 *
 *  @return 是否支持旋转
 */
-(BOOL)shouldAutorotate
{

	NSLog(@"======>> %d", __shouldAutorotate);
	return __shouldAutorotate;
}

/**
 *  适配旋转的类型
 *
 *  @return 类型
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
	if (!__shouldAutorotate) {
		return UIInterfaceOrientationMaskPortrait;
	}
	return UIInterfaceOrientationMaskAllButUpsideDown;
}


- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */

	if (self.topViewController.wgb_disableInteractivePop) {
		return NO;
	}

	if ([gestureRecognizer translationInView: gestureRecognizer.view].x <= 0) {
		return NO;
	}

	if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
		return NO;
	}

	return (self.childViewControllers.count != 1);
}

	//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	return (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && [otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]);
}


/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 60, 44);
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"navRuturnBtn"]
                    forState:UIControlStateNormal];
        leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        leftButton.imageEdgeInsets=UIEdgeInsetsMake(0, -15, 0, 0);
        leftButton.titleLabel.font = JJFont(15);
        [leftButton setAdjustsImageWhenHighlighted:NO];
        [leftButton addTarget:self action:@selector(backLastViewController) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
		// 修改tabBra的frame
	CGRect frame = self.tabBarController.tabBar.frame;
	frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
	self.tabBarController.tabBar.frame = frame;
}

- (void)backLastViewController{
    [self popViewControllerAnimated:YES];
}

@end
