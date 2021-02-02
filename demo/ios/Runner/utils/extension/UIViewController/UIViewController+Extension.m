//
//  UIViewController+DebugJump.m
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UIViewController+Extension.h"
#include <objc/runtime.h>
#import "YTWebViewController.h"

@implementation UIViewController (Extension)

-(BOOL)wgb_disableInteractivePop{
	return [objc_getAssociatedObject(self, @selector(wgb_disableInteractivePop)) boolValue];
}

-(void)setWgb_disableInteractivePop:(BOOL)wgb_disableInteractivePop{
	objc_setAssociatedObject(self, @selector(wgb_disableInteractivePop), @(wgb_disableInteractivePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark- 判断登录
+ (void)judgeLoginStateWithViewController:(UIViewController *)VC
								thanBlock:(dispatch_block_t)thanBlock{
	NSString *user_id = [JJYSLoginTool getUid];
	if (user_id.length==0) {
		[UIViewController loginPageWithType:NSLoginPageTypeWithPush fromController: VC];
	}else{
		!thanBlock? : thanBlock();
	}
}

+ (void)loginPageWithType:(NSLoginPageType)pushType fromController:(UIViewController *)fromController {

    
}

+ (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        topVC = ((UINavigationController *)topVC).topViewController;
    }
    return topVC;
}

+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        } else {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}


- (void)setLeftBarAndBackgroundColor
{
    if (self.navigationController.viewControllers.count != 1 ||
        self.navigationController.presentingViewController) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    }
    self.view.backgroundColor = kBgColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)btnClick
{
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addBackButtonIfNeed
{
    if (self.navigationController.viewControllers.count != 1) {
        return;
    }
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)setupNavBarTitleViewWithText:(NSString *)text {
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = JJFont(18);
    titleLable.text = text;
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;
}

- (void)setupNavBarPopButton {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backToLastController) target:self];
}

- (void)addNavLeftButtonWithImage:(NSString *)imageName {
    UIBarButtonItem *leftBarItme = [UIBarButtonItem initWithNormalImage:imageName target:self action:@selector(leftBarButtonAction)];
    self.navigationItem.leftBarButtonItem = leftBarItme;
}

- (void)addNavRightButtonWithImage:(NSString *)imageName {
    UIBarButtonItem *leftBarItme = [UIBarButtonItem initWithNormalImage:imageName target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = leftBarItme;
}

- (void)leftBarButtonAction {

}

- (void)rightBarButtonAction {
    
}

- (void)setupNavBarRightButtonWithTitle:(NSString *)title {
    JGTouchEdgeInsetsButton *rightButton = [JGTouchEdgeInsetsButton buttonWithType:UIButtonTypeCustom];
    rightButton.width = 44;
    rightButton.height = 30;
    rightButton.x = SCREEN_WIDTH - rightButton.width;
    rightButton.y = 0;
    rightButton.titleLabel.font = JJFont(18);
    rightButton.touchEdgeInsets = UIEdgeInsetsMake(-10, -40, 0, -20);
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(navRightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)navRightAction:(UIButton *)button{

}


- (void)setupNavBarLeftButtonWithTitle:(NSString *)title {
    JGTouchEdgeInsetsButton *leftButton = [JGTouchEdgeInsetsButton buttonWithType:UIButtonTypeCustom];
    leftButton.width = 44;
    leftButton.height = 30;
    leftButton.x = 0;
    leftButton.y = 0;
    leftButton.titleLabel.font = JJFont(18);
    leftButton.touchEdgeInsets = UIEdgeInsetsMake(0, -10, -10, -20);
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(navLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)navLeftAction:(UIButton *)button{



}




- (void)hiddenNavBarPopButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
}

- (void)backToLastController {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)backToMain {
    if (self.navigationController.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{

        }];
    }
}


- (void)addJumpButton:(SEL)action title:(NSString *)title
{
    CGSize size = [self.view bounds].size;
    
    UIButton *button = [[UIButton alloc] initWithFrame:
                        CGRectMake(20, size.height - 40,
                                   size.width-40, 40)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    if ([self respondsToSelector:action]) {
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)hideHubWithOnlyText:(NSString *)hideText {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = hideText;
//    hud.margin = 10.f;
//    hud.yOffset = 80.f;
//    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:2];
}

- (UILabel *)createLabWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment {
    UILabel *commonLab = [[UILabel alloc] init];
    commonLab.frame = frame;
    commonLab.backgroundColor = bgColor;
    commonLab.text = text;
    commonLab.font = font;
    commonLab.textColor = textColor;
    commonLab.textAlignment = alignment;
    return commonLab;
}

- (BOOL)validateNumberWithPhoneNumber:(NSString *)phoneNumber {
    if (phoneNumber.length == 0 ) {
        return NO;
    }
    NSString*pattern =@"^1+[34578]+\\d{9}";
    
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}

- (void)showHud {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
}

- (void)showHudWithMsg:(NSString *)msg {
    [SVProgressHUD showWithStatus:msg];
}

- (void)hiddenHud {
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [SVProgressHUD dismiss];
}

- (void)saveWithUserDefaultsWithObject:(id)object key:(NSString *)key {
    if (object == nil || !key.length) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

- (id)getUserDefaultWithKey:(NSString *)key {
    if (!key.length) {
        return nil;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id object = [defaults objectForKey:key];
    if (!object) {
        return nil;
    }else {
        return object;
    }
    return nil;
}


#pragma mark- 提示错误信息
- (void)showErrorMessageWithText:(NSString*)text{
    [self showErrorMessageWithText:text duration:1.5];

}

- (void)showErrorMessageWithText:(NSString*)text duration:(NSTimeInterval)duration{

    [SVProgressHUD showErrorWithStatus:text];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


#pragma mark- 提示成功信息
- (void)showSuccessMessageWithText:(NSString*)text{
    [self showSuccessMessageWithText:text duration:1.5];
}

- (void)showSuccessMessageWithText:(NSString *)text duration:(NSTimeInterval)duration {
    
    [SVProgressHUD showSuccessWithStatus:text];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - 收键盘
- (void)tapToShrinkKeyboard {
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shrinkKeyboard)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)shrinkKeyboard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - 快速创建刷新

/**
 创建上下拉刷新

 @param scrollView scrollView 或者scrollView的子类
 @param headerAction header下拉的回调target
 @param headerNormalTitle header正常刷新提示
 @param headerPullingTitle header下拉刷新提示
 @param headerRefreshingTitle header正在刷新提示
 @param footerAction footer上拉的刷新回调
 @param footerNormalTitle footer 正常的提示
 @param footerRefreshingTitle footer正在刷新的提示
 @param footerNoMoreDataTitle footer 没有更多数据的提示
 */
- (void)addRefreshWithBasicView: (UIScrollView *)scrollView
				                headerAction: (SEL)headerAction
	        headerRefreshNormalTitle: (NSString *)headerNormalTitle
	         headerRefreshPullingTitle: (NSString *)headerPullingTitle
		           headerRefreshingTitle: (NSString *)headerRefreshingTitle
				                  footerAction: (SEL)footerAction
			  footerRefreshNormalTitle: (NSString *)footerNormalTitle
		             footerRefreshingTitle: (NSString *)footerRefreshingTitle
		         footerNoMoreDataTitle: (NSString *)footerNoMoreDataTitle{
		//下拉刷新
	MJRefreshNormalHeader * header =
	[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:headerAction];
		// 设置文字
	[header setTitle:headerNormalTitle forState:MJRefreshStateIdle];
	[header setTitle:headerPullingTitle forState:MJRefreshStatePulling];
	[header setTitle:headerRefreshingTitle forState:MJRefreshStateRefreshing];
		// 设置字体
	header.stateLabel.font = [UIFont systemFontOfSize:15];
	header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
	header.automaticallyChangeAlpha = YES;

		// 设置颜色
	header.stateLabel.textColor = KHeavyColor;
	header.lastUpdatedTimeLabel.textColor = KHeavyColor;
	scrollView.mj_header = header;
		//上拉刷新
	MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction: footerAction];
		// 设置文字
	[footer setTitle:footerNormalTitle forState:MJRefreshStateIdle];
	[footer setTitle:footerRefreshingTitle forState:MJRefreshStateRefreshing];
	[footer setTitle:footerNoMoreDataTitle forState:MJRefreshStateNoMoreData];

		// 设置字体
	footer.stateLabel.font = [UIFont systemFontOfSize:17];
	footer.automaticallyHidden = YES ;
		// 设置颜色
	footer.stateLabel.textColor = KHeavyColor ;
	scrollView.mj_footer = footer;
}


- (void)addHeaderRefreshWithBasicView:(UIScrollView *)scrollView headerAction:(SEL)headerAction headerRefreshNormalTitle:(NSString *)headerNormalTitle headerRefreshPullingTitle:(NSString *)headerPullingTitle headerRefreshingTitle:(NSString *)headerRefreshingTitle {
    //下拉刷新
    MJRefreshNormalHeader * header =
    [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:headerAction];
        // 设置文字
    [header setTitle:headerNormalTitle forState:MJRefreshStateIdle];
    [header setTitle:headerPullingTitle forState:MJRefreshStatePulling];
    [header setTitle:headerRefreshingTitle forState:MJRefreshStateRefreshing];
        // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    header.automaticallyChangeAlpha = YES;

        // 设置颜色
    header.stateLabel.textColor = KHeavyColor;
    header.lastUpdatedTimeLabel.textColor = KHeavyColor;
    scrollView.mj_header = header;
}

#pragma mark- 跳转至网页
//无参
- (void)skipNoParamWebViewWithURL:(NSString *)url title:(NSString *)navTitle {

	XXWebViewController *webController = [[XXWebViewController alloc] initNoParamWebWithUrl:url title:navTitle FromController:self];
	[self.navigationController pushViewController:webController animated:YES];
}

//远程登陆shopniu系统
- (void)skipShopniuWebViewVCWithURL:(NSString *)url title:(NSString *)navTitle {
	XXWebViewController *webController = [[XXWebViewController alloc] initWithShopniuWebViewWithUrl:url title:navTitle FromController:self];
	[self.navigationController pushViewController:webController animated:YES];
}

//有固定参
- (void)skipWebViewVCWithURL:(NSString *)url tittle:(NSString *)navTitle{

	YTWebViewController *webVC = [[YTWebViewController alloc] init];
	webVC.urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[self.navigationController pushViewController:webVC animated:YES];

//	XXWebViewController *webController =[[XXWebViewController alloc]initWithWebViewControllerWithWebViewUrl: url title: navTitle FromController: self];
//	[self.navigationController pushViewController:webController animated:YES];
}

#pragma mark - 可选择跳转网页方法
- (void)skipWebViewVCWithURL:(NSString *)url tittle:(NSString *)navTitle requestType:(JJWebRequestType)requestType paramDict:(NSDictionary *)dict{
	XXWebViewController *webController =[[XXWebViewController alloc] initWithMethodType:requestType parameters:dict url: url title: navTitle];
	[self.navigationController pushViewController:webController animated:YES];
}

	///MARK: -引导添加App Store的评论
- (void)guideAppstoreComment{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	BOOL isNotGuide = [[defaults objectForKey:@"isNotGuideAppstore"] boolValue];
	if (isNotGuide) {
		return ;
	}
		//跳转到评价页面
	UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"评价一下" message:@"我们拼了命加班，只希望那个您能用的爽。给个五星好评吧亲！" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"五星好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSString *str = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&id=%@",KJJYSAPPID];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
	}];
	UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"稍后评价" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
	}];
//	UIAlertAction *action3 =[UIAlertAction actionWithTitle:@"不再提示" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//		[defaults setObject:@"YES" forKey:@"isNotGuideAppstore"];

	[alertVC addAction: action1];
	[alertVC addAction: action2];
//	[alertVC addAction: action3];
	[self presentViewController: alertVC animated:YES completion:^{
	}];
}


#pragma mark- 添加这样一个蒙版的关联对象
- (void)setShareBackGroundView:(UIView *)shareBackGroundView{
	objc_setAssociatedObject(self, @selector(shareBackGroundView), shareBackGroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)shareBackGroundView{
	return objc_getAssociatedObject(self, _cmd);
}

#pragma mark-展示蒙版
- (void)showBackgroundMask{
	UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
	background.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	background.opaque = NO;
	[background addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
		[self dismissBackgroundMask];
	}];
	self.shareBackGroundView = background;
	self.shareBackGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
	[kCurrentWindow addSubview: self.shareBackGroundView];
}

#pragma mark-添加蒙版 并且包含一个事件
- (void)showBackgroundMask:(dispatch_block_t)dismissBlock{
	UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
	background.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	background.opaque = NO;
	[background addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
		if (dismissBlock) {
			dismissBlock();
		}
		[self dismissBackgroundMask];
	}];
	self.shareBackGroundView = background;
	[UIView animateWithDuration:0.25 animations:^{
		self.shareBackGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
		[kCurrentWindow addSubview: self.shareBackGroundView];
	}];
}

#pragma mark-移除蒙版
- (void)dismissBackgroundMask{
	[UIView animateWithDuration: 0.25 animations:^{
		self.shareBackGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
		[self.shareBackGroundView removeFromSuperview];
	}];
}


#pragma mark- 添加底部按钮
- ( UIButton * _Nullable )addApplyBottomButtonHaveChat:(BOOL)isChat
						 clickAction:(void(^)(NSInteger index ))callBack {
	UIView *bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, KHIGHT-50 , KWIDTH , 50 )];
//	if([NSObject isIPhoneX]){
//		bottomBgView.y -= BottomHeight;
//		bottomBgView.height += BottomHeight;
//	}
	bottomBgView.backgroundColor = KWhiteColor;
	[self.view addSubview: bottomBgView];

	NSArray *titles = @[];
	if (isChat) {
		titles = @[@"在线咨询",@"立即预约"];
	}else{
		titles = @[@"立即预约"];
	}

	NSArray *colors = @[KOrangeColor,KLightColor];

	CGFloat buttonW = KWIDTH / titles.count;
	CGFloat buttonH = 50 ;
	CGFloat buttonX = 0;
	CGFloat buttonY = 0;
	for (NSInteger i = 0; i < titles.count ; i++) {
		UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
		buttonX = buttonW *i ;
		button.frame = CGRectMake(buttonX, buttonY, buttonW , buttonH);
		[button setTitle: titles[i] forState:UIControlStateNormal];
		button.backgroundColor = isChat? colors[i] : KLightColor ;
		button.tag = isChat? i : 1; ///细节处理
		__weak typeof(button) weak_button = button;
		[button addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
			!callBack? : callBack(weak_button.tag);
		}];
		[bottomBgView addSubview: button];
		if (button.tag == 1) {
			return  button;
		}
    }
	return nil;
}

#pragma mark- 跳转商务通
- (void)skipChatBusinessLink{
	NSString *urlString = [JJYSLoginTool BusinessChatLink];
//	[NSString stringWithFormat:@"https://awt.zoosnet.net/LR/Chatpre.aspx?id=AWT48536194&cid=&lng=cn&sid=&p=com.carapace.ddys.client&d=%.f",[[NSDate date] timeIntervalSince1970]];
	[self skipWebViewVCWithURL:  urlString  tittle:@"在线咨询"];
}



/**
	自定义弹窗相关
 */
#pragma mark- 大标题 左右俩按钮的wgbStyle风格弹窗
- (void)wgbStyle_alertWithTitle:(NSString *)title
			  cancelButtonTitle:(NSString *)cancelTitle
		  confirmButtonTitle:(NSString *)confirmTitle
				   cancelAction:(void(^)(void))cancelCallBackBlock
			   comfirmAction:(void(^)(void))confirmCompeteBlock {
	WGBAlertView *alert = [[WGBAlertView alloc] initWithFrame: CGRectMake(0,0, KWIDTH , KHIGHT)];
	UIView *viewCtrl = [[UIView alloc] init];
	viewCtrl.backgroundColor = JJWhiteColor;
	CGFloat rate = (320.0 - 56.0)/320.0;
	CGFloat viewWidth = rate * SCREEN_WIDTH;
	CGFloat viewHeight = 178.0;
	viewCtrl.width = viewWidth;
	viewCtrl.height = viewHeight;
	viewCtrl.layer.cornerRadius = 4;

	UILabel *remindLab = [[UILabel alloc] init];
	remindLab.x = 10;
	remindLab.y = 40;
	NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]};
	CGSize retSize = [title boundingRectWithSize: CGSizeMake(viewCtrl.width-20, HUGE) 	options:\
					  NSStringDrawingTruncatesLastVisibleLine |
					  NSStringDrawingUsesLineFragmentOrigin |
					  NSStringDrawingUsesFontLeading
									  attributes:attribute
										 context:nil].size;
	CGFloat textHight = retSize.height;
	remindLab.width = viewCtrl.width-20;
	remindLab.height = textHight;
	remindLab.text = title;
	remindLab.numberOfLines = 0;
	remindLab.textAlignment = NSTextAlignmentCenter;
	remindLab.font =  [UIFont boldSystemFontOfSize:18];
	[viewCtrl addSubview:remindLab];

	UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
	cancelButton.titleLabel.font = JJFont(15);
	cancelButton.width = (viewCtrl.width - 20 * 2 -10) / 2;
	cancelButton.x = 20;
	cancelButton.y = CGRectGetMaxY(remindLab.frame) + 40;
	cancelButton.height = 36;
	cancelButton.backgroundColor = [UIColor clearColor];
	cancelButton.layer.borderColor = [UIColor initHex:0xe0e0e0].CGColor;
	cancelButton.layer.borderWidth = 0.9;
	[viewCtrl addSubview:cancelButton];
	[cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
	[cancelButton setTitleColor: [UIColor initHex:0x999999] forState:UIControlStateNormal];
	[cancelButton addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
		[alert hide];
		cancelCallBackBlock();
	}];
	cancelButton.layer.cornerRadius = 4;

	UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
	confirmButton.titleLabel.font = JJFont(15);
	confirmButton.x = viewCtrl.width - 20 - cancelButton.width;
	confirmButton.y = cancelButton.y;
	confirmButton.width = cancelButton.width;
	confirmButton.height = cancelButton.height;
	confirmButton.backgroundColor = KMAINCOLOR;
	[confirmButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
	[confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
	confirmButton.layer.cornerRadius = 4;
	viewCtrl.height = CGRectGetMaxY(confirmButton.frame)+20;
	[confirmButton addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
		[alert hide];
		confirmCompeteBlock();
	}];

	[viewCtrl addSubview:confirmButton];
	alert.contentView = viewCtrl;
	[alert show];
}


#pragma mark- 自定义统一风格的 [取消]-[确认] 弹框
- (void)customAlertWithTitle:(NSString *)title
		   cancelButtonTitle:(NSString *)cancelTitle
		  confirmButtonTitle:(NSString *)confirmTitle
				cancelAction:(void(^)(void))cancelCallBackBlock
			   comfirmAction:(void(^)(void))confirmCompeteBlock {

	WGBAlertView *alert = [[WGBAlertView alloc] initWithFrame:CGRectMake(0,0, KWIDTH , KHIGHT)];
	UIView *viewCtrl = [[UIView alloc] init];
	viewCtrl.backgroundColor = JJWhiteColor;
	CGFloat rate = (320.0 - 56.0)/320.0;
	CGFloat viewWidth = rate * SCREEN_WIDTH;
	CGFloat viewHeight = 178.0;
	viewCtrl.width = viewWidth;
	viewCtrl.height = viewHeight;
	viewCtrl.layer.cornerRadius = 4;

	CGFloat imgWidth = 55.0;
	CGFloat imgHeight = imgWidth;
	UIImageView *headImageView = [[UIImageView alloc] init];
	headImageView.x = (viewCtrl.width - imgWidth)/2;
	headImageView.y = 32;
	headImageView.width = imgWidth;
	headImageView.height = imgHeight;
	headImageView.image=[UIImage imageNamed:@"suprise"];
	[viewCtrl addSubview:headImageView];

	UILabel *remindLab = [[UILabel alloc] init];
	remindLab.x = 10;
	remindLab.y = CGRectGetMaxY(headImageView.frame) + 10;
	NSDictionary *attribute = @{NSFontAttributeName: JJFont(15)};
	CGSize retSize = [title boundingRectWithSize: CGSizeMake(viewCtrl.width-20, HUGE) 	options:\
					  NSStringDrawingTruncatesLastVisibleLine |
					  NSStringDrawingUsesLineFragmentOrigin |
					  NSStringDrawingUsesFontLeading
									  attributes:attribute
										 context:nil].size;
	CGFloat textHight = retSize.height;
	remindLab.width = viewCtrl.width-20;
	remindLab.height = textHight;
	remindLab.text = title;
	remindLab.numberOfLines = 0;
	remindLab.textAlignment = NSTextAlignmentCenter;
	remindLab.font = JJFont(15);
	[viewCtrl addSubview:remindLab];

	UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
	cancelButton.width = (viewCtrl.width - 20 * 2 -10) / 2;
	cancelButton.x = 20;
	cancelButton.y = CGRectGetMaxY(remindLab.frame) + 10;
	cancelButton.height = 36;
	cancelButton.backgroundColor = [UIColor clearColor];
	cancelButton.layer.borderColor = [[UIColor initHex:0xe0e0e0] CGColor];
	cancelButton.layer.borderWidth = 0.9;
	[viewCtrl addSubview:cancelButton];
	[cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
	[cancelButton setTitleColor:[UIColor initHex:0x999999] forState:UIControlStateNormal];
	[cancelButton addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
		[alert hide];
		cancelCallBackBlock();
	}];
	cancelButton.layer.cornerRadius = 4;

	UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
	confirmButton.x = viewCtrl.width - 20 - cancelButton.width;
	confirmButton.y = cancelButton.y;
	confirmButton.width = cancelButton.width;
	confirmButton.height = cancelButton.height;
	confirmButton.backgroundColor = KMAINCOLOR;
	[confirmButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
	[confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
	confirmButton.layer.cornerRadius = 4;
	viewCtrl.height = CGRectGetMaxY(confirmButton.frame)+20;
	[confirmButton addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
		[alert hide];
		confirmCompeteBlock();
	}];

	[viewCtrl addSubview:confirmButton];
	alert.contentView = viewCtrl;
	[alert show];
}


	// [取消]-[确认] 弹框
- (void)customAlertWithTitle:(NSString *)title
				cancelAction:(void(^)(void))cancelCallBackBlock
			   comfirmAction:(void(^)(void))confirmCompeteBlock{

	[self customAlertWithTitle:title cancelButtonTitle:@"取消" confirmButtonTitle:@"确认" cancelAction:cancelCallBackBlock comfirmAction:confirmCompeteBlock];
}


#pragma mark- 乐值商城免责声明
- (void)reliefStatementAlertTip:(dispatch_block_t)skipBlock{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	BOOL isNotFirstLezhiShop = [[defaults objectForKey:@"isNotFirstLezhiShop"] boolValue];
	if (isNotFirstLezhiShop) {
		!skipBlock? : skipBlock();
		return ;
	}
	[defaults setObject:@"YES" forKey:@"isNotFirstLezhiShop"];
	[defaults synchronize];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"免责声明" message:@"本服务由乐值商城提供,相关服务和责任将由第三方承担,如有问题请咨询该公司客服。" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
	[alertView show];
	alertView.callBackBlock = ^(UIAlertView *alertView, NSInteger index) {
		!skipBlock? : skipBlock();
	};
}

#pragma mark- 增加一点点黑色底部 润个色 好看一些
+(void)addIphoneXBottomBar{
	if(IS_Iphone_X){
		UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, (KHIGHT-34), KWIDTH , BottomHeight)];
		bottomBar.backgroundColor = JJBlackColor;
		[kCurrentWindow addSubview: bottomBar];
	}
}

#pragma mark-弹窗提示
- (void)alertTipCitycode:(NSString *)citycode serviceType:(ServiceObjectType)type{
    // 加入corp_id 后 不提示
//	if (![citycode isEqualToString: [JJYSLoginTool defaultCityCode]]) {
//		NSString *message = nil ;
//		if (type == ServiceObjectTypeMatron) {
//			message = @"月嫂所在城市与您所选的服务城市不一致,是否进行下单?";
//		}else{
//			message = @"育婴师所在城市与您所选的服务城市不一致,是否进行下单?";
//		}
//		[self customAlertWithTitle: message  cancelButtonTitle:@"取消重选" confirmButtonTitle:@"确定" cancelAction:^{
//		} comfirmAction:^{
//		}];
//	}
}

@end
