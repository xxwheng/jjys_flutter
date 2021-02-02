//
//  ConstantLiterals.h
//  JJYSPlusPlus
//
//  Created by Wangguibin on 16/5/10.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**  家家月嫂客户端的AppID  */
FOUNDATION_EXTERN NSString *const KJJYSAPPID ;
/**  友盟AppKey  */
FOUNDATION_EXTERN NSString * const  KUMSocalAppKey;
/**  新浪微博AppKey  */  // 没有用到
//FOUNDATION_EXTERN NSString * const  KSinaAppKey;
/**  新浪微博AppSecret  */
//FOUNDATION_EXTERN NSString * const  KSinaAppSecret;
/**  新浪微博AppRedirectURL  */
FOUNDATION_EXTERN NSString * const  KSinaAppRedirectURL;
/** 微信 AppID  */
FOUNDATION_EXTERN NSString *const KWeiXinAppID ;
/**  微信APPSecret  */
FOUNDATION_EXTERN NSString *const KWeiXinAppSecret;

/// 微信Universal Links
FOUNDATION_EXTERN NSString *const KWeiXinUniversalLinks;

FOUNDATION_EXTERN NSString *const kUmShareUrl;

	///极光推送 没有用到
//FOUNDATION_EXTERN NSString *const KJPushAppSecret;
//FOUNDATION_EXTERN NSString *const kJPushAPPKey;

///百度地图定位的AppKey
FOUNDATION_EXTERN NSString *kBaiduAppKey ;


/**
 *  umeng qq分享
 */
FOUNDATION_EXTERN NSString *const kQQAppId;
FOUNDATION_EXTERN NSString *const kQQAppKey;


/**  用户ID  */
FOUNDATION_EXTERN NSString *const  KUID;
/**  用户指纹  */
FOUNDATION_EXTERN NSString *const KUser_token;

//web 登录的  id 和 token
FOUNDATION_EXTERN NSString *const  ShopniuID;
FOUNDATION_EXTERN NSString *const ShopniuToken;

/**  预产期  */
FOUNDATION_EXTERN NSString *const KPredicDate;

FOUNDATION_EXTERN NSString *const kDefaultCityCode ;
FOUNDATION_EXTERN NSString *const kDefaultCorpId;

FOUNDATION_EXTERN NSString * const kApMobile4s;
FOUNDATION_EXTERN NSString * const kApMobile5s;
FOUNDATION_EXTERN NSString * const kApMobile6s;
FOUNDATION_EXTERN NSString * const kApMobile6plus;

/**  导航栏的高度  */
UIKIT_EXTERN CGFloat const  KNavigationBarHeight ;
/**  边缘边距  */
UIKIT_EXTERN CGFloat const  KMargin;
/**  状态栏高度  */
UIKIT_EXTERN CGFloat const KStatusBarHeight;


#pragma mark-- 确认订单页面参数设置
/**   提交订单 按钮的标题  */
FOUNDATION_EXTERN NSString *const KCommitButtonTitle;

/**  提交订单按钮的高度  */
UIKIT_EXTERN CGFloat const  KCommitButtonHeight ;
/**  月嫂信息  */
UIKIT_EXTERN CGFloat const KMatronHeaderFirstPartHeight ;
/**  服务信息  */
UIKIT_EXTERN CGFloat const KServiceInfoHeight;
/**  套餐高度  */
UIKIT_EXTERN CGFloat const KComboHeight ;
/**  联系信息  */
UIKIT_EXTERN CGFloat const KContactInfoHeight ;
/**  费用合计  */
UIKIT_EXTERN  CGFloat  const KExpensesTotalHeight;
/**  遵守协议  */
UIKIT_EXTERN CGFloat const KFollowProtocolHeight ;


#pragma mark- 确定支付页面参数
UIKIT_EXTERN CGFloat const KTotalHeight; //确定支付页面视图的高度

///MARK: 短单限制天数
FOUNDATION_EXTERN CGFloat const KShortOrderLimitDay ;

#pragma mark -  Refresh Content
///MARK: 问题的上下拉刷新提示语
FOUNDATION_EXTERN NSString *const kQuestionHeaderNormalTitle ;
FOUNDATION_EXTERN NSString *const kQuestionHeaderPullingTitle ;
FOUNDATION_EXTERN NSString *const kQuestionHeaderRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kQuestionFooterNormalTitle ;
FOUNDATION_EXTERN NSString *const kQuestionFooterRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kQuestionFooterNoMoreDataTitle ;
///MARK: 答案提示语
FOUNDATION_EXTERN NSString *const kAnswerHeaderNormalTitle ;
FOUNDATION_EXTERN NSString *const kAnswerHeaderPullingTitle ;
FOUNDATION_EXTERN NSString *const kAnswerHeaderRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kAnswerFooterNormalTitle ;
FOUNDATION_EXTERN NSString *const kAnswerFooterRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kAnswerFooterNoMoreDataTitle ;
///MARK: 专家列表提示语
FOUNDATION_EXTERN NSString *const kExpertHeaderNormalTitle ;
FOUNDATION_EXTERN NSString *const kExpertHeaderPullingTitle ;
FOUNDATION_EXTERN NSString *const kExpertHeaderRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kExpertFooterNormalTitle ;
FOUNDATION_EXTERN NSString *const kExpertFooterRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kExpertFooterNoMoreDataTitle ;
///MARK: 视频列表提示语
FOUNDATION_EXTERN NSString *const kVideoHeaderNormalTitle ;
FOUNDATION_EXTERN NSString *const kVideoHeaderPullingTitle ;
FOUNDATION_EXTERN NSString *const kVideoHeaderRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kVideoFooterNormalTitle ;
FOUNDATION_EXTERN NSString *const kVideoFooterRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kVideoFooterNoMoreDataTitle ;
///MARK: 月嫂列表
FOUNDATION_EXTERN NSString *const kMatronHeaderNormalTitle ;
FOUNDATION_EXTERN NSString *const kMatronHeaderPullingTitle ;
FOUNDATION_EXTERN NSString *const kMatronHeaderRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kMatronFooterNormalTitle ;
FOUNDATION_EXTERN NSString *const kMatronFooterRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kMatronFooterNoMoreDataTitle ;
///MARK: 月嫂关注列表
FOUNDATION_EXTERN NSString *const kConcernHeaderNormalTitle ;
FOUNDATION_EXTERN NSString *const kConcernHeaderPullingTitle ;
FOUNDATION_EXTERN NSString *const kConcernHeaderRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kConcernFooterNormalTitle ;
FOUNDATION_EXTERN NSString *const kConcernFooterRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kConcernFooterNoMoreDataTitle ;
///MARK: 评论列表
FOUNDATION_EXTERN NSString *const kCommentHeaderNormalTitle ;
FOUNDATION_EXTERN NSString *const kCommentHeaderPullingTitle ;
FOUNDATION_EXTERN NSString *const kCommentHeaderRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kCommentFooterNormalTitle ;
FOUNDATION_EXTERN NSString *const kCommentFooterRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kCommentFooterNoMoreDataTitle ;

	/// MARK:  订单列表
FOUNDATION_EXTERN NSString *const kOrderListHeaderNormalTitle ;
FOUNDATION_EXTERN NSString *const kOrderListHeaderPullingTitle ;
FOUNDATION_EXTERN NSString *const kOrderListHeaderRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kOrderListFooterNormalTitle ;
FOUNDATION_EXTERN NSString *const kOrderListFooterRefreshingTitle ;
FOUNDATION_EXTERN NSString *const kOrderListFooterNoMoreDataTitle ;

	///MARK: - 平台服务费,押金,保险等说明文字
FOUNDATION_EXTERN NSString *const kPlatformFeeDescirpition ;
FOUNDATION_EXTERN NSString *const kDepositFeeDescription ;
FOUNDATION_EXTERN NSString *const kInsuranceFeeDescirpition ;

