//
//  UIViewController+DebugJump.h
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXWebViewController.h"

typedef NS_ENUM(NSUInteger, NSLoginPageType) {
    NSLoginPageTypeWithPush = 0,
    NSLoginPageTypeWithPresent
};

@interface UIViewController (Extension)

/**
 禁止右滑返回属性
 */
@property (nonatomic, assign)BOOL wgb_disableInteractivePop;


+ (UIViewController *)appRootViewController;
- (void)addBackButtonIfNeed;
- (void)setLeftBarAndBackgroundColor;
- (void)addJumpButton:(SEL)action title:(NSString *)title;
- (void)btnClick;
- (void)hideHubWithOnlyText:(NSString *)hideText;
/**
 *  进入登录页面
 *
 *  @param pushType       进入方式
 *  @param fromController 从哪个控制器进入
 */
+ (void)loginPageWithType:(NSLoginPageType)pushType fromController:(UIViewController *)fromController;

#pragma mark- 判断登录
+ (void)judgeLoginStateWithViewController:(UIViewController *)VC
								thanBlock:(dispatch_block_t)thanBlock;

// 给导航栏添加标题
- (void)setupNavBarTitleViewWithText:(NSString *)text;

// 给导航栏添加返回键
- (void)setupNavBarPopButton;
//导航栏右侧按钮
- (void)setupNavBarRightButtonWithTitle:(NSString *)title;
//导航栏左按钮
- (void)setupNavBarLeftButtonWithTitle:(NSString *)title ;

// 隐藏导航栏返回键
- (void)hiddenNavBarPopButton;

// 添加一个常用的lab
- (UILabel *)createLabWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;

/**
 *  验证电话合法性
 */
- (BOOL)validateNumberWithPhoneNumber:(NSString *)phoneNumber;

/**
 *  显示遮罩层 */
- (void)showHud;

- (void)showHudWithMsg:(NSString *)msg;

/**
 *  隐藏遮罩层 */
- (void)hiddenHud;

- (void)addNavLeftButtonWithImage:(NSString *)imageName;
- (void)addNavRightButtonWithImage:(NSString *)imageName;


- (void)saveWithUserDefaultsWithObject:(id)object key:(NSString *)key;

- (id)getUserDefaultWithKey:(NSString *)key;


#pragma mark- 提示错误信息 X
- (void)showErrorMessageWithText:(NSString*)text;
- (void)showErrorMessageWithText:(NSString*)text duration:(NSTimeInterval)duration;

#pragma mark- 提示成功信息 √
- (void)showSuccessMessageWithText:(NSString*)text;
- (void)showSuccessMessageWithText:(NSString *)text duration:(NSTimeInterval)duration;

#pragma mark - 收键盘 --需要用到键盘的控制器里调用此方法
- (void)tapToShrinkKeyboard;

#pragma mark - 快速创建刷新
/**
 创建上下拉刷新

 @param scrollView: scrollView 或者scrollView的子类
 @param headerAction: header下拉的回调target
 @param headerNormalTitle: header正常刷新提示
 @param headerPullingTitle: header下拉刷新提示
 @param headerRefreshingTitle: header正在刷新提示
 @param footerAction: footer上拉的刷新回调
 @param footerNormalTitle: footer 正常的提示
 @param footerRefreshingTitle: footer正在刷新的提示
 @param footerNoMoreDataTitle: footer 没有更多数据的提示
 */
- (void)addRefreshWithBasicView: (UIScrollView *)scrollView
				   headerAction: (SEL)headerAction
	   headerRefreshNormalTitle: (NSString *)headerNormalTitle
	  headerRefreshPullingTitle: (NSString *)headerPullingTitle
		  headerRefreshingTitle: (NSString *)headerRefreshingTitle
				   footerAction: (SEL)footerAction
	   footerRefreshNormalTitle: (NSString *)footerNormalTitle
		  footerRefreshingTitle: (NSString *)footerRefreshingTitle
		  footerNoMoreDataTitle: (NSString *)footerNoMoreDataTitle ;

- (void)addHeaderRefreshWithBasicView: (UIScrollView *)scrollView
             headerAction: (SEL)headerAction
 headerRefreshNormalTitle: (NSString *)headerNormalTitle
headerRefreshPullingTitle: (NSString *)headerPullingTitle
    headerRefreshingTitle: (NSString *)headerRefreshingTitle;

#pragma mark- 跳转至网页

	//无参
- (void)skipNoParamWebViewWithURL:(NSString *)url title:(NSString *)navTitle;

//远程登陆shopniu系统
- (void)skipShopniuWebViewVCWithURL:(NSString *)url title:(NSString *)navTitle;

- (void)skipWebViewVCWithURL:(NSString *)url
					  tittle:(NSString *)navTitle ;
#pragma mark - 可选择跳转网页方法
- (void)skipWebViewVCWithURL:(NSString *)url
					  tittle:(NSString *)navTitle
				 requestType:(JJWebRequestType)requestType
				   paramDict:(NSDictionary *)dict ;


	///MARK: -引导添加App Store的评论
- (void)guideAppstoreComment ;


#pragma mark-蒙版对象
@property (nonatomic,strong) UIView *shareBackGroundView;
#pragma mark-展示蒙版
- (void)showBackgroundMask;
#pragma mark-添加蒙版 并且包含一个事件
- (void)showBackgroundMask:(dispatch_block_t)dismissBlock;
#pragma mark-移除蒙版
- (void)dismissBackgroundMask;

#pragma mark- 添加底部按钮
/*!
 @method  [在线咨询 | 立即预约]
 @abstract  添加底部按钮
 @discussion   - 使用方法是: 需要添加在线咨询按钮的情况下,区分根据按钮tag值 index来标识不同的点击事件, 没有在线咨询按钮的时候,就一个预约按钮,可以不区分,直接处理相关事件,作出响应.
 @param isChat 是否要添加在线咨询按钮 ,如果添加,那就是两个按钮,如果不添加就是只有一个预约按钮并且按钮的tag值为 1
 @param callBack 一个按钮回调,返回index ,在线咨询的tag值为 0
 */
- (UIButton *)addApplyBottomButtonHaveChat:(BOOL)isChat
						 clickAction:(void(^)(NSInteger index))callBack ;

#pragma mark- 跳转商务通
- (void)skipChatBusinessLink ;


#pragma mark- 大标题 左右俩按钮的wgbStyle风格弹窗
- (void)wgbStyle_alertWithTitle:(NSString *)title
			  cancelButtonTitle:(NSString *)cancelTitle
		  confirmButtonTitle:(NSString *)confirmTitle
				   cancelAction:(void(^)(void))cancelCallBackBlock
			   comfirmAction:(void(^)(void))confirmCompeteBlock;

#pragma mark- 自定义统一风格的 [取消]-[确认] 弹框
- (void)customAlertWithTitle:(NSString *)title
		   cancelButtonTitle:(NSString *)cancelTitle
		  confirmButtonTitle:(NSString *)confirmTitle
				cancelAction:(void(^)(void))cancelCallBackBlock
			   comfirmAction:(void(^)(void))confirmCompeteBlock ;

	/// [取消]-[确认] 弹框
- (void)customAlertWithTitle:(NSString *)title
				cancelAction:(void(^)(void))cancelCallBackBlock
			   comfirmAction:(void(^)(void))confirmCompeteBlock ;

#pragma mark- 乐值商城免责声明
- (void)reliefStatementAlertTip:(dispatch_block_t)skipBlock ;

#pragma mark- 给iPhone X增加一点点黑色底部 , 润个色 , 好看一些
+(void)addIphoneXBottomBar;
#pragma mark-弹窗提示
- (void)alertTipCitycode:(NSString *)citycode serviceType:(ServiceObjectType)type ;

@end
