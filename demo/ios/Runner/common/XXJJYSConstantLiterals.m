//
//  ConstantLiterals.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 16/5/10.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "XXJJYSConstantLiterals.h"

/**  家家月嫂客户端的AppID  */
NSString *const KJJYSAPPID =@"1089421770";

/**  友盟AppKey  */
NSString * const  KUMSocalAppKey =@"56d92b4367e58efcbb000a25";
/**  新浪微博AppKey  */
//NSString  * const  KSinaAppKey     = @"";
///**  新浪微博AppSecret  */
//NSString *  const    KSinaAppSecret = @"";
///**  新浪微博AppRedirectURL  */
//NSString *  const    KSinaAppRedirectURL = @"";
/** 微信 AppID  */
NSString *const KWeiXinAppID = @"wx23a7b918a2e733cc";
/**  微信APPSecret  */
NSString *const KWeiXinAppSecret =@"e3c33176c537afdeebfbb2ca97cdbe44";
/// 微信Universal Links
NSString *const KWeiXinUniversalLinks = @"https://m.jjys168.com/userclient/";
///
NSString *const kUmShareUrl = @"http://www.jjys168.com/jjys/index.html";
/// QQ
NSString *const kQQAppId = @"1105142181";
NSString *const kQQAppKey = @"YNjBnwLKrBnFrZ2w";


	///极光推送
// NSString *const KJPushAppSecret = @"888eef0af928236b8f45cd75";
// NSString *const kJPushAPPKey = @"3cd4b9b327983e3b42442f3a";

  ///百度地图定位的AppKey
 NSString *kBaiduAppKey = @"0eRZdXjy17ev9NVOv1x2anwDwnsQz2li";


/**  用户ID  */
NSString *const KUID =@"User_id";
/**  用户指纹  */
NSString *const KUser_token =@"user_token";

NSString *const  ShopniuID = @"ShopniuId";
NSString *const ShopniuToken = @"ShopniuToken";


NSString *const KPredicDate =@"predicDate";
NSString *const kDefaultCityCode = @"defaultCityCode";
NSString *const kDefaultCorpId = @"defaultCorpID";

/**  NavigationBar的高度  */
CGFloat const  KNavigationBarHeight =44.0f;
/**  边缘间距  */
CGFloat const  KMargin =8.0f;
/**  状态栏高度  */
CGFloat const KStatusBarHeight =20.0f;

NSString * const kApMobile4s = @"4s";
NSString * const kApMobile5s = @"5s";
NSString * const kApMobile6s = @"6s";
NSString * const kApMobile6plus = @"6plus";

#pragma mark-- 确认订单页面自定义View参数设置
/**  提交按钮的高度  */
CGFloat  const  KCommitButtonHeight  =  50.0f ;
/**  月嫂信息高度 */
CGFloat const KMatronHeaderFirstPartHeight =150.0f;
/**  服务信息高度  */
CGFloat const KServiceInfoHeight  =90.0f;
/**  套餐高度高度 */
CGFloat const KComboHeight =295.0f;
/**  联系信息高度  */
CGFloat const KContactInfoHeight =220.0f;
/**  费用合计  */
CGFloat  const KExpensesTotalHeight=440.0f;
/**  遵守协议  */
CGFloat const KFollowProtocolHeight =86.0f;
/**  提交订单 按钮的标题  */
NSString *const KCommitButtonTitle =@"提交订单";


#pragma mark- 确认支付
CGFloat const KTotalHeight = 915.0f;

/**  短单限制天数  */
CGFloat const KShortOrderLimitDay = 10;

#pragma mark - 专家问答模块`上下拉刷新提示语`
	/// MARK: 问题提示语
NSString *const kQuestionHeaderNormalTitle = @"下拉即将刷新问题列表";
NSString *const kQuestionHeaderPullingTitle = @"松开就可以刷新问题列表";
NSString *const kQuestionHeaderRefreshingTitle = @"正在刷新问题列表....";
NSString *const kQuestionFooterNormalTitle = @"上拉加载更多问题";
NSString *const kQuestionFooterRefreshingTitle = @"正在加载更多问题 ...";
NSString *const kQuestionFooterNoMoreDataTitle = @"以上是全部问题";

/// MARK: 答案提示语
NSString *const kAnswerHeaderNormalTitle = @"下拉即将刷新答案列表";
NSString *const kAnswerHeaderPullingTitle = @"松开就可以刷新答案列表";
NSString *const kAnswerHeaderRefreshingTitle = @"正在刷新答案列表....";
NSString *const kAnswerFooterNormalTitle = @"上拉加载更多答案";
NSString *const kAnswerFooterRefreshingTitle = @"正在加载更多答案 ...";
NSString *const kAnswerFooterNoMoreDataTitle = @"以上是全部答案";

/// MARK: 专家列表提示语
NSString *const kExpertHeaderNormalTitle = @"下拉即将刷新专家列表";
NSString *const kExpertHeaderPullingTitle = @"松开就可以刷新专家列表";
NSString *const kExpertHeaderRefreshingTitle = @"正在刷新专家列表....";
NSString *const kExpertFooterNormalTitle = @"上拉加载更多专家";
NSString *const kExpertFooterRefreshingTitle = @"正在加载更多专家 ...";
NSString *const kExpertFooterNoMoreDataTitle = @"以上是全部专家";

/// MARK:  视频列表模块
NSString *const kVideoHeaderNormalTitle = @"下拉即将刷新视频列表";
NSString *const kVideoHeaderPullingTitle = @"松开就可以刷新视频列表";
NSString *const kVideoHeaderRefreshingTitle = @"正在刷新视频列表....";
NSString *const kVideoFooterNormalTitle = @"上拉加载更多视频";
NSString *const kVideoFooterRefreshingTitle = @"正在加载更多视频 ...";
NSString *const kVideoFooterNoMoreDataTitle = @"以上是全部视频";

/// MARK: 月嫂列表
NSString *const kMatronHeaderNormalTitle = @"下拉家家为您刷新最新数据";
NSString *const kMatronHeaderPullingTitle = @"松开就可以刷新数据";
NSString *const kMatronHeaderRefreshingTitle = @"正在刷新数据....";
NSString *const kMatronFooterNormalTitle = @"上拉加载更多数据";
NSString *const kMatronFooterRefreshingTitle = @"正在加载更多数据 ...";
NSString *const kMatronFooterNoMoreDataTitle = @"全部数据加载完毕";

/// MARK:  月嫂关注列表
NSString *const kConcernHeaderNormalTitle = @"下拉即将刷新关注列表";
NSString *const kConcernHeaderPullingTitle = @"松开就可以刷新关注列表";
NSString *const kConcernHeaderRefreshingTitle = @"正在刷新关注列表....";
NSString *const kConcernFooterNormalTitle = @"上拉加载更多关注的月嫂";
NSString *const kConcernFooterRefreshingTitle = @"正在加载更多关注的月嫂 ...";
NSString *const kConcernFooterNoMoreDataTitle = @"关注的月嫂数据加载完毕";

/// MARK:  评价列表
NSString *const kCommentHeaderNormalTitle = @"下拉即将刷新评价列表";
NSString *const kCommentHeaderPullingTitle = @"松开就可以刷新评价列表";
NSString *const kCommentHeaderRefreshingTitle = @"正在刷新评价列表....";
NSString *const kCommentFooterNormalTitle = @"上拉加载更多评价的月嫂";
NSString *const kCommentFooterRefreshingTitle = @"正在加载更多评价的月嫂 ...";
NSString *const kCommentFooterNoMoreDataTitle = @"月嫂评价加载完毕";

	/// MARK:  订单列表
NSString *const kOrderListHeaderNormalTitle = @"下拉即将刷新订单列表";
NSString *const kOrderListHeaderPullingTitle = @"松开就可以刷新订单列表";
NSString *const kOrderListHeaderRefreshingTitle = @"正在刷新订单列表....";
NSString *const kOrderListFooterNormalTitle = @"上拉加载更多订单";
NSString *const kOrderListFooterRefreshingTitle = @"正在加载更多订单数据...";
NSString *const kOrderListFooterNoMoreDataTitle = @"没有更多订单了";

NSString *const kPlatformFeeDescirpition = @"平台服务费按年收取，不同等级育婴师收取的平台服务费标准不同。";
NSString *const kDepositFeeDescription = @"工资押金收取育婴师一个月的工资，作为育婴师最后一个月的工资，发生退单、更换育婴师等情况时按实际费用多退少补。";
NSString *const kInsuranceFeeDescirpition = @"家政服务保险按年收取，保障雇主及育婴师在服务期间因意外伤害、意外事故等导致的损失。";



