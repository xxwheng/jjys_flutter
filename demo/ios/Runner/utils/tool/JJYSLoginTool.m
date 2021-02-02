/*
 *  @FileName(文件名):  JJYSLoginTool.m
 *  @ProjectName(工程名):   JJYSPlusPlus
 *  @CreateDate(创建日期):   Created by Wangguibin on 16/5/29.
 *  @Copyright(版权所有):     Copyright © 2016年 王贵彬. All rights reserved.
 */


#import "JJYSLoginTool.h"

@implementation JJYSLoginTool

+ (NSUserDefaults *)defaults{
	return [NSUserDefaults standardUserDefaults];
}

+ (void)setCorpPrice:(BOOL)isCorp {
	[[self defaults] setBool:isCorp forKey:@"isCorpPrice"];
	[[self defaults] synchronize];
}

+ (BOOL)isCorpPrice {
	return [[self defaults] boolForKey:@"isCorpPrice"];
}

+ (void)setUid:(NSString *)uid
{
    [[self defaults] setObject:uid forKey: KUID];
    [[self defaults] synchronize];
}

+ (NSString *)getUid
{
//    return @"37";
    return [self getUidShowLogin:NO];
}

+ (void)setShopniuId:(NSString *)shopId {
	[[self defaults] setObject:shopId forKey:ShopniuID];
	[[self defaults] synchronize];
}

+ (NSString *)getShopniuId {
	return [[self defaults] stringForKey:ShopniuID];;
}


+ (void)phoneNumber:(NSString *)phone{
	[[self defaults] setObject: phone forKey: @"phoneNumber"];
	[[self defaults] synchronize];
}
+ (NSString *)getPhoneNumber{
	return [[self defaults] valueForKey:@"phoneNumber"];
}


+ (NSString *)getUidShowLogin:(BOOL)showViewController {
  NSString *user_id = [[self defaults] stringForKey:KUID];
//  if (showViewController) {
//    BindingPhoneViewController *bindVC = [[BindingPhoneViewController alloc]
//        initWithNibName:@"BindingPhoneViewController"
//                 bundle:nil];
//    [[UIApplication sharedApplication]
//            .keyWindow.rootViewController presentViewController:bindVC
//                                                       animated:YES
//                                                     completion:nil];
//  }

  return user_id;
}

/**设置指纹*/
+ (void)setUser_token:(NSString*)user_token{

    [[self defaults] setObject:user_token forKey:KUser_token];
    [[self defaults] synchronize];
}

/** 移除指纹*/
+ (void)removeUser_token{

    [[self defaults] removeObjectForKey:KUser_token];
    [[self defaults] synchronize];

}

/**  获取指纹  */
+ (NSString *)getUser_token{

 return [[self defaults] valueForKey:KUser_token];
}

+ (void)setShopniuToken:(NSString *)shopToken {
	[[self defaults] setObject:shopToken forKey:ShopniuToken];
	[[self defaults] synchronize];
}

+ (NSString *)getShopniuToken {
	return [[self defaults] valueForKey:ShopniuToken];
}

+ (void)removeShopniuToken {
	[[self defaults] removeObjectForKey:ShopniuToken];
	[[self defaults] synchronize];
}



	/// 获取默认城市代码
+ (NSString *)defaultCityCode{
	return  [[self defaults] objectForKey:kDefaultCityCode];
}



+ (NSString *)cityName {
    return [self getCorpTitle];
}

+ (void)exsitLogin {
    [[self defaults] removeObjectForKey:KUID];
	[[self defaults] removeObjectForKey:ShopniuID];
    [[self defaults] synchronize];
    [JJYSLoginTool removeUser_token];
	[JJYSLoginTool removeShopniuToken];
}


#pragma mark-合伙人编号
+ (void)setSaleTeamNumber:(NSString *)number{
	[[self defaults] setObject:number forKey:@"number"];
	[[self defaults] synchronize];
}

+ (NSString *)getSaleTeamNumber{
	return  [[self defaults] objectForKey:@"number"];
}


#pragma mark-合伙人类型
+ (void)setSaleRole:(NSString *)role{
	[[self defaults] setObject:role forKey:@"role"];
	[[self defaults] synchronize];
}
+ (NSString *)getSaleRole{
	return  [[self defaults] objectForKey:@"role"];
}

#pragma mark- 合伙人加入时间
+ (void)setSaleJoinTime:(NSString *)time{
	[[self defaults] setObject: time forKey:@"time"];
	[[self defaults] synchronize];
}
+ (NSString *)getSaleJoinTime {
	return  [[self defaults] objectForKey:@"time"];
}

#pragma mark- 海报缓存更新标识
+ (void)setPosterTime:(NSString *)timeStamp{
	[[self defaults] setObject: timeStamp forKey:@"posterTimeStamp"];
	[[self defaults] synchronize];
}
+ (NSString *)posterTime{
	return  [[self defaults] objectForKey:@"posterTimeStamp"];
}

#pragma mark-存储海报链接
+ (void)setPosterLinkString:(NSString *)link{
	[[self defaults] setObject: link forKey:@"posterLink"];
	[[self defaults] synchronize];
}
+ (NSString *)getPosterLinkString{
	return  [[self defaults] objectForKey:@"posterLink"];
}

#pragma mark- 设置切换域名的参数
//+ (void)setCityServerTag:(NSString *)city_server {
//	[[self defaults] setObject: city_server forKey:@"city_server"];
//	[[self defaults] synchronize];
//}
//+ (NSString *)getCityServerTag{
//	return  [[self defaults] objectForKey:@"city_server"];
//}

#pragma mark- 400电话
+ (void)setHotLineWithPhoneNumber:(NSString *)phone{
	[[self defaults] setObject: phone forKey:@"hotline"];
	[[self defaults] synchronize];
}
+ (NSString *)hotLinePhoneNumber{
//	return [[self defaults] objectForKey:@"hotline"];
    return [self getCorpPhone];
}

#pragma mark - 加盟商

    ///设置默认的城市
+ (void)setDefaultCity:(NSString*)cityCode{
    [[self defaults] setObject: cityCode forKey: kDefaultCityCode];
    [[self defaults] synchronize];
}

+ (void)setCorp:(NSString*)corp_id phone:(NSString *)phone {
    NSString *key = [NSString stringWithFormat:@"%@_corp_phone", corp_id];
    [[self defaults] setObject: phone forKey: key];
    [[self defaults] synchronize];
}

+ (NSString *)getCorpPhone {
    NSString *corpId = [self getCorpId];
    NSString *key = [NSString stringWithFormat:@"%@_corp_phone", corpId];
    return [[self defaults] valueForKey:key];
}

/// 设置加盟商
+ (void)setCorpId: (NSString*)corp_id {
    [[self defaults] setObject:corp_id forKey: kDefaultCorpId];
    [[self defaults] synchronize];
}

/// 获取corpId
+ (NSString *)getCorpId {
    NSString *corpID = [[self defaults] valueForKey:kDefaultCorpId];
    if (corpID == nil || [corpID isEqualToString:@""]) {
        corpID = @"1";
    }
    return corpID;
}

+ (void)setCorpTitle:(NSString*)title {
    [[self defaults] setObject:title forKey:@"corpTitle"];
    [[self defaults] synchronize];
}

+ (NSString*)getCorpTitle {
    NSString *title = [[self defaults] objectForKey:@"corpTitle"];
    if (title) {
        return title;
    }
    return @"深圳家家月嫂";
}

+ (void)setCorpCityTitle:(NSString*)title {
    [[self defaults] setObject:title forKey:@"corpCityTitle"];
    [[self defaults] synchronize];
}

+ (NSString *)getCorpCityTitle {
    NSString *cityTitle = [[self defaults] valueForKey:@"corpCityTitle"];
    if (cityTitle) {
        return cityTitle;
    }
    return @"深圳";
}

+ (void)setCorpChatLink:(NSString *)link {
    NSLog(@"%@----", link)
    [[self defaults] setObject: link forKey:@"CorpChatLink"];
    [[self defaults] synchronize];
}

+ (NSString *)getCorpChatLink {
    
    NSMutableString *link = [[self defaults] objectForKey:@"CorpChatLink"];
    if (link && ![link isEqualToString:@""]) {
        return link;
    }
    return [self BusinessChatLink];
}

#pragma mark- 商务通的链接
+ (void)setBusinessChatWithLink:(NSString *)link{
	[[self defaults] setObject: link forKey:@"BusinessChatLink"];
	[[self defaults] synchronize];
}

+ (NSString *)BusinessChatLink{
	return [[self defaults] objectForKey:@"BusinessChatLink"];
}

	///MARK:- 护理日志的订单id
+ (void)setNurseOrderID:(NSString *)nurseOrderID{
	[[self defaults] setObject: nurseOrderID forKey:@"nurseOrderID"];
	[[self defaults] synchronize];
}
+ (NSString *)nurseOrderID{
	return [[self defaults] objectForKey:@"nurseOrderID"];
}

	///MARK:- 宝宝id
+ (void)setNurseBabyID:(NSString *)baby_id{
	[[self defaults] setObject: baby_id forKey:@"kBabyID"];
		[[self defaults] synchronize];
}

+ (NSString *)babyID{
	return [[self defaults] objectForKey:@"kBabyID"];
}


@end
