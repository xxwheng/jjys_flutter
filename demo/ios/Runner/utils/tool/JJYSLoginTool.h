/*
 *  @FileName(文件名):  JJYSLoginTool.h
 *  @ProjectName(工程名):    JJYSPlusPlus
 *  @CreateDate(创建日期):   Created by Wangguibin on 16/5/29.
 *  @Copyright(版权所有):        Copyright © 2016年 王贵彬. All rights reserved.
 */


#import <Foundation/Foundation.h>

@interface JJYSLoginTool : NSObject

+ (BOOL)isCorpPrice;
+ (void)setCorpPrice:(BOOL)isCorp;

//设置UID
+ (void)setUid:(NSString *)uid;
//获取UID
+ (NSString *)getUid;
+ (NSString *)getUidShowLogin:(BOOL)showViewController;

+ (void)phoneNumber:(NSString *)phone;
+ (NSString *)getPhoneNumber;

#pragma mark-合伙人编号
+ (void)setSaleTeamNumber:(NSString *)number;
+ (NSString *)getSaleTeamNumber;

#pragma mark-合伙人类型
+ (void)setSaleRole:(NSString *)role;
+ (NSString *)getSaleRole;

#pragma mark- 合伙人加入时间
+ (void)setSaleJoinTime:(NSString *)time;
+ (NSString *)getSaleJoinTime ;

#pragma mark- 海报缓存更新标识
+ (void)setPosterTime:(NSString *)timeStamp;
+ (NSString *)posterTime;
#pragma mark-存储海报链接
+ (void)setPosterLinkString:(NSString *)link;
+ (NSString *)getPosterLinkString;

/**设置指纹*/
+ (void)setUser_token:(NSString*)user_token;
/** 移除指纹*/
+(void)removeUser_token;
/**  获取指纹  */
+ (NSString *)getUser_token;

/**
	shopniu  id 和 token
 	用于web登录
 */
+ (void)setShopniuId:(NSString *)shopId;
+ (NSString *)getShopniuId;
+ (void)setShopniuToken:(NSString *)shopToken;
+ (void)removeShopniuToken;
+ (NSString *)getShopniuToken;


+ (void)setCorpTitle:(NSString*)title;

+ (NSString*)getCorpTitle;

+ (void)setCorpId: (NSString*)corp_id;

/// 加盟商id
+ (NSString *)getCorpId;
/// 加盟商标题
+ (NSString *)getCorpCityTitle;
/// 加盟商标题-城市
+ (void)setCorpCityTitle:(NSString*)title;

+ (void)setCorp:(NSString*)corp_id phone:(NSString *)phone;

+ (NSString *)getCorpPhone;

+ (void)setCorpChatLink:(NSString *)link;

+ (NSString *)getCorpChatLink;

	///设置默认的城市
+ (void)setDefaultCity:(NSString*)cityCode;
	/// 获取默认城市代码
+ (NSString *)defaultCityCode;


+ (NSString *)cityName;


/////默认重置深圳环境
//+ (void)resetShenzhenEnvironment ;

/**
 *  退出登录 */
+ (void)exsitLogin;

#pragma mark- 设置切换域名的参数
//+ (void)setCityServerTag:(NSString *)city_server ;
//+ (NSString *)getCityServerTag;

#pragma mark- 400电话
+ (void)setHotLineWithPhoneNumber:(NSString *)phone;
+ (NSString *)hotLinePhoneNumber;

#pragma mark- 商务通的链接
+ (void)setBusinessChatWithLink:(NSString *)link;
+ (NSString *)BusinessChatLink;


///MARK:- 护理日志的订单id
+ (void)setNurseOrderID:(NSString *)nurseOrderID;
+ (NSString *)nurseOrderID;

///MARK:- 宝宝ID
+ (void)setNurseBabyID:(NSString *)baby_id;
+ (NSString *)babyID;


@end
