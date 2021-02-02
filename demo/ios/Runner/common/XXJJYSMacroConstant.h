//
//  MacroConstant.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 16/5/10.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#ifndef MacroConstant_h
#define MacroConstant_h

#ifdef __OBJC__
//如果是OC项目 就引入这两个头文件
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#endif

#ifdef DEBUG
//Debug 阶段打印
#define NSLog(FORMAT, ...) fprintf(stderr,"\n方法:%s  第%d行 \n 内容->: %s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
//发布阶段 取消打印
#define NSLog(...)
#endif

	///弹出一条信息 弹窗
#define kAlertShowMessage(msg)  	UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message: msg delegate:nil cancelButtonTitle: nil otherButtonTitles:@"确认", nil];\
[alert show];


///适配iOS 11 scrollView向下偏移
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


///AppDeleagte
#define JJAppdelegate     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];


/**  打印方法名  */
#define WGBFunc  WGBLog(@"%s",__func__);

	///ROOTVC
#define kRootVC  [UIApplication sharedApplication].keyWindow.rootViewController

	//当前window
#define kCurrentWindow [[UIApplication sharedApplication].windows firstObject]

	//非空的字符串 避免输出null
#define kUnNilStr(str) ((str && ![str isEqual:[NSNull null]])?str:@"")

	//app名称
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

	//app版本 todo
//#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//G－C－D  开启异步线程 回调block
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

//主线程
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//判断是否iOS7系统
#define IsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)
#define IsIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO)

#define IsIOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >=11.0 ? YES : NO)
#define kJJYSStatusBarHeight   (IsIOS11? 64 : 20)


//获取当前系统版本
#define KCURRENT_VERSION  [ [ [UIDevice currentDevice]  systemVersion ] floatValue]

//加载比较大的图片  优化性能
#define LOADIMAGE(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

//设置字体
#define kPingFang(F)  [UIFont fontWithName:@"PingFang SC" size:(F)]
#define KSetFontSize(A)  [UIFont systemFontOfSize:A]
#define JJFont(a) [UIFont fontWithName:@"Avenir-Light" size:(a)]
//字体
#define KFontLightGrayColor   [UIColor colorWithRed:0.7529 green:0.7529 blue:0.7529 alpha:1.0]

//颜色 RGBA
#define RGBA(R, G, B, A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//白色
#define KWhiteColor  [UIColor whiteColor]

#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)?YES:NO

	// 物理屏幕宽度
#define KWIDTH  [[UIScreen mainScreen]bounds].size.width

	// 物理屏幕高度
#define KHIGHT [[UIScreen mainScreen]bounds].size.height

	// View 坐标(x,y)和宽高(width,height)
#define X(v)               (v).frame.origin.x
#define Y(v)               (v).frame.origin.y
#define WIDTH(v)           (v).frame.size.width
#define HEIGHT(v)          (v).frame.size.height

#define MinX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
#define MinY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标

#define MidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define MidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标

#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度


//状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏+状态栏
#define NavBarHeight   (44.0 + kStatusBarHeight)
//tabBar高度
#define kTabBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#define IS_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_Iphone_X  (IS_Iphone && KHIGHT == 812.0)
#define BottomHeight (IS_Iphone_X? 34 : 0)
#define XBottomSpace ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)

//主题颜色
#define KMAINCOLOR     RGB(126,27,195)

/**按钮主题色*/
#define KButtonColor   RGB(148,90,189)

/**  导航栏颜色  */
#define KNavColor   RGB(121,36,189)

/**  屎黄色  */
#define KGoldColor  RGB(253,194,49)

//字体颜色
#define KFontColor  [UIColor colorWithRed:0.1961 green:0.1961 blue:0.1961 alpha:1.0]

/**  深色  */
#define KHeavyColor  [UIColor colorWithRed:0.4784 green:0.0863 blue:0.7412 alpha:1.0]

#define KLightColor  [UIColor colorWithRed:0.5843 green:0.3373 blue:0.749 alpha:1.0]

// 底部背景颜色
#define kBgColor    RGB(247,248,249)

//随机色
#define KRandom  [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f  blue:arc4random()%256/255.0f alpha:1.0f]

#define JJRandomColor  [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f  blue:arc4random()%256/255.0f alpha:1.0f]
//白色
#define JJWhiteColor [UIColor whiteColor]
//黑色
#define JJBlackColor [UIColor blackColor]
//橙色
#define KOrangeColor RGB(243, 198, 130)
//绿色
#define KGreenColor   RGB(73, 224, 191)
//灰色背景
#define KGrayBgColor   RGB(228, 228, 228)
#define KsearchBgColor RGB(236,241,248)
//RGB
#define RGB(R,G,B)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0f]

//弱引用宏
#define Weak(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//强引用宏 (原理同上)
#define Strong(o)  autoreleasepool{} __strong typeof(o) o = o##Weak;


/**
 *  iPhone4 or iPhone4s
 */
#define  iPhone4_4s     (KWIDTH == 320.f && KHIGHT == 480.f ? YES : NO)

/**
 *  iPhone5 or iPhone5s
 */
#define  iPhone5_5s     (KWIDTH == 320.f && KHIGHT == 568.f ? YES : NO)

/**
 *  iPhone6 or iPhone6s
 */
#define  iPhone6_6s     (KWIDTH == 375.f && KHIGHT == 667.f ? YES : NO)

/**
 *  iPhone6Plus or iPhone6sPlus
 */
#define  iPhone6_6sPlus (KWIDTH == 414.f && KHIGHT == 736.f ? YES : NO)


//获取view的frame
#define KGetFrame(view)   view.frame

//获取view的size
#define  KGetSize(view)     view.frame.size

//获取view的位置起始点
#define KGetOrigin(view)   view.frame.origin

// 检测block是否可用 
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

#define kNotofication [NSNotificationCenter defaultCenter]

 /// 防空值判断
#define VerifyValue(value)\
({id tmp;\
if ([value isKindOfClass:[NSNull class]])\
tmp = nil;\
else\
tmp = value;\
tmp;\
})\

///判断字符串为空  YES 为空  NO不为空
#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)


#define kNetworkNotReachability ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus <= 0)  //无网


//月嫂等级
typedef NS_ENUM(NSInteger, MatronLevel) {
	MatronLevelLV1 =1,//一星
	MatronLevelLV2 =2,//二星
	MatronLevelLV3 = 3,    //三星
	MatronLevelLV4,        //四星
	MatronLevelLV5,        //五星
	MatronLevelLV6,        //六星
	MatronLevelGoldBrand,  //金牌
	MatronLevelHouseKeeper,//月子管家
	MatronLevelBronzeMedalHouseKeeper = 11, ///铜牌月子管家
	MatronLevelSilverMedalHouseKeeper = 12,//银牌月子管家
	MatronLevelGoldMedalHouseKeeper = 13,//金牌月子管家
};

	/// 育婴师等级
typedef NS_ENUM(NSInteger, YuyingLevel) {
	YuyingLevelSecondStage = 2,
	YuyingLevelPrimaryStage = 3, //初级
	YuyingLevelMidStage, //中级
	YuyingLevelHighStage,//高级
	YuyingLevelStarStage,//星级✨
	YuyingLevelGoldBrandStage,//金牌🏅
};

//月嫂年龄段
typedef NS_ENUM(NSInteger, MatronAge) {
  MatronAgeNoLimit = 0,  //不限
  MatronAgeBelow30,  // 30以下
  MatronAgeFrom30To40,  // 30~40
  MatronAgeAbove40,  // 40以上
};

//月嫂工作经验
typedef NS_ENUM(NSInteger, MatronWorkExperience) {
  MatronWorkExperienceNoLimit = 0,  //不限
  MatronWorkExperienceFrom1To2Year,  // 1~2年
  MatronWorkExperienceFrom3To5Year,  // 3~5年
  MatronWorkExperienceAbove5Year,  // 5年以上
};

	/// 服务类型
typedef NS_ENUM(NSInteger, ServiceObjectType) {
	ServiceObjectTypeMatron = 1, ///月嫂
	ServiceObjectTypeProlactin = 2, ///催乳师
	ServiceObjectTypeNurseryTeacher = 3,///育婴师
	ServiceObjectTypeUniversal = 99 ///通用产品
};


//月嫂服务天数套餐
//typedef NS_ENUM(NSInteger, MatronServiceCombo) {
//  MatronServiceComboNoLimit = 0,  //不限
//  MatronServiceCombo26Days = 26,  // 26天
//  MatronServiceCombo42Days = 42,  // 42天
//  MatronServiceCombo78Days = 78,  // 78天
////  MatronServiceCombo1Days = 1,
//  MatronServiceCombo3Days = 3,
//  MatronServiceCombo5Days = 5
//};

//筛选排序类型
typedef NS_ENUM(NSInteger, MatronQueryType) {
  MatronQueryTypeComposite = 0,  //综合
  MatronQueryTypePrice,          //价格
  MatronQueryTypeEvaluate,       //评价
  MatronQueryTypeFilter,         //筛选
};

typedef NS_ENUM(NSInteger,JJYSPayType) {
    JJYSPayTypePayDownMoney=1, //支付定金或者全款  有的选 (俩圆圈按钮)
    JJYSPayTypePayTailMoney ,//支付尾款  [没得选 就一个]
    JJYSPayTypePayAllMoney,//支付全款  [短单什么的]
	JJYSPayTypePayLimitQuotaMoney,// 支付限额什么的
};

// 1.未付款  2.预付款 3已付款，4已退款
typedef NS_ENUM(NSInteger,JJYSOrderMoneyStatusType) {
	JJYSOrderMoneyStatusTypeNoPay = 1,
	JJYSOrderMoneyStatusTypePayStart,
	JJYSOrderMoneyStatusTypeAlreadyPayed,
	JJYSOrderMoneyStatusTypeRefundMoney
};



//1、订单列表无需分组
//2、订单状态及按钮情况如下：
//状态1：等待支付；详情页显示按钮：客服、取消订单、马上付款；列表页显示按钮：客服、取消订单、马上付款。
//状态2：已付定金，详情页显示按钮 ：客服、退款、支付尾款；列表页显示按钮：客服、支付尾款。
//状态3：等待服务，详情页显示按钮：客服、退款；列表页显示按钮：客服。
//状态4：服务中，详情页显示按钮：客服、退款、换人；列表页显示按钮：客服。
//状态5：已完成，详情页显示按钮：客服、评论；列表页显示按钮：客服、评论。
//状态6：已评论，详情页显示按钮：客服；列表页显示按钮：客服。
//状态7：已终止，详情页显示按钮：客服；列表页显示按钮：客服。
//状态8：退款中，详情页显示按钮：客服；列表页显示按钮：客服。
//状态9：已退款，详情页显示按钮：客服；列表页显示按钮：客服。
//状态10：已取消，详情页显示按钮：客服；列表页显示按钮：客服。
//状态5、6、9、10用绿色显示，其余状态用橙色。

//返回值枚举
//process	tinyint(1) [0]	订单进度，0未付款，1已付订金，2等待服务，3服务中，4服务结束，5待评论，6待结算，7已完成，8已取消，9退款中，10已退款
//
//status	tinyint(1) [1]	订单支付状态，1未付款，2预付款，3已付款，4已退款
//pay_type	tinyint(1) unsigned [0]	支付类型，0 预付款，1全款


/**
 *  最新
 */
//process	tinyint(1) [0]	订单进度，0未付款，1已付订金，2等待服务，3服务中，4服务完成，5已评价，6待结算，7已完成(月嫂端)，8已取消，9退款中，10已退款
//status	tinyint(1) [1]	订单支付状态，1未付款，2 预付款，3 已付款，4 已退款

typedef NS_ENUM(NSInteger, JJYSOrderProcessType) {
  JJYSOrderProcessTypeNoPay = 0,  //等待支付: 客服 , 取消订单 , 马上付款
  JJYSOrderProcessTypeDepositsPaid,  // 已付定金:    客服、支付尾款
  JJYSOrderProcessTypeWaitService,       //等待服务:  客服
  JJYSOrderProcessTypeServiceBegin,  //服务中 : 客服
  JJYSOrderProcessTypeServiceEnd,    //服务结束: 客服、评论
    
  JJYSOrderProcessTypeWaitComment,   //  已评论: 客服  ( 下同  )
  JJYSOrderProcessTypeWaitClearing,  // 待结算
  JJYSOrderProcessTypeCommpeleted,   //已完成
  JJYSOrderProcessTypeCanceled,      //已取消
  JJYSOrderProcessTypeRefunding,     //退款中
  JJYSOrderProcessTypeRefunded,      //已退款
};

// 以上出现情况订单列表里有4种不同按钮
//  1. 客服				[已取消  退款中 已退款 ]
// 2. 客服,评价     [订单结束]
// 3.客服、支付尾款       [等待服务]
// 4.客服 , 取消订单 , 马上付款 [未付款]
// 5.评论 续单 支付尾款    [服务中..]

/**有节假日的 ==>> */
// 6.  续费、 评价 支付尾款  [服务中]
// 7. 评论 续费  续单 [服务中]
// 8.评价 尾款


	/// 性别
typedef NS_ENUM(NSInteger,JJYSToolSexType) {
	JJYSToolSexTypeUnKnow = 0, //未知,女装大佬,大*萌妹...性别跨越 ...
	JJYSToolSexTypeBoy, //男
	JJYSToolSexTypeGirl //女
};

	// 1 普通类型 ，2 tab switch 3 .选择项目(圆) 4.不需要填写 5选择项目（方形）
typedef NS_ENUM(NSInteger,JJYSNurerToolType) {
	JJYSNurerToolTypeSelectItemGeneral = 1,
	JJYSNurerToolTypeSelectItemTabSwitch = 2,
	JJYSNurerToolTypeSelectItemCicleRound = 3 ,
	JJYSNurerToolTypeSelectItemNone = 4 ,
	JJYSNurerToolTypeSelectItemSquare = 5 ,
};



#endif /* MacroConstant_h */
