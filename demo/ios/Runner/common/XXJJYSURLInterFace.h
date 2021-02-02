/*
 *  @FileName(文件名):  XXJJYSURLInterFace.h
 *  @ProjectName(工程名):    JJYSPlusPlus
 *  @CreateDate(创建日期):   Created by Wangguibin on 16/5/10.
 *  @Copyright(版权所有):        Copyright © 2016年 王贵彬. All rights reserved.
 */

#import <Foundation/Foundation.h>

#pragma mark-------服务器的环境---------

//websocket网关定义
//内网开发
//#define KWSServerHostPort  @"ws://m.dev.jjys168.com:8181"
//外网测试
#define KWSServerHostPort  @"ws://m.t.jjys168.com:8181"
//线上正式
//#define KWSServerHostPort  @"ws://m.jjys168.com:8181"

///http or https
/**  测试环境  */
//#define KServerHost @"http://api.dev.jjys168.com"
/**  外网环境  */
#define KServerHost  @"http://api.t.jjys168.com"
/**  正式线上环境 [已认证https] */
//#define KServerHost   @"https://m.jjys168.com/api/"


#pragma mark H5
//内网测试
//#define JJWebHeaderHost @"http://m.dev.jjys168.com/html/"
//外网测试
#define JJWebHeaderHost @"http://m.t.jjys168.com/html/"
//正式环境
//#define JJWebHeaderHost @"https://m.jjys168.com/html/"


#pragma mark- 新闻页面URL
   //内网测试
//#define JJWebNewsHost @"http://m.dev.jjys168.com/a/"
	//外网测试
#define JJWebNewsHost @"http://m.t.jjys168.com/a/"
	//正式环境
//#define JJWebNewsHost @"https://m.jjys168.com/a/"


#pragma mark- 生成二维码相关的一些静态日常用的域名
	//内网测试
//	#define JJCommonWebHost @"http://www.dev.jjys168.com/a/"
	//外网测试
	#define JJCommonWebHost @"http://www.t.jjys168.com/a/"
	//正式环境
//#define JJCommonWebHost @"https://www.jjys168.com/a/"



#pragma mark-合伙人生成海报
////http://www.dev.jjys168.com/a/activityPoster?user_id= XXXX
//#define JJSaleTeamCreatePosterUrl(user_id)   [NSString stringWithFormat:@"%@%@%@",JJCommonWebHost,@"activityPoster?user_id=",(user_id)]

//http://m.t.jjys168.com/a/ToolRecipeIndex.html

///月子餐
#define kPostpartumMeal [NSString stringWithFormat:@"%@%@",JJWebNewsHost,@"ToolRecipeIndex.html"]

// 关于家家
#define JJAboutUsUrl    [NSString stringWithFormat:@"%@%@",JJWebHeaderHost,@"aboutus.html"]


	//龚慧娴 12-6 16:38
	///html/protocol_yuezi.html?citycode=103212   这个是月嫂的
// protocol.html  服务协议
#define JJProtocolUrl   [NSString stringWithFormat:@"%@%@",JJWebHeaderHost,@"protocol_yuezi.html"]

//注册协议 http://m.jjys168.com/html/registerProtocol.html
#define JJRegisterProtocolURL  [NSString stringWithFormat:@"%@%@",JJWebHeaderHost,@"registerProtocol.html"]

//育婴师服务内容 http://m.jjys168.com/html/yuyin_serviceinfo.html?level=1
#define JJYuyingSkillerServiceinfoURL(level)   [NSString stringWithFormat:@"%@%@%@",JJWebHeaderHost,@"yuyin_serviceinfo.html?level=",level]
	//月嫂服务内容
#define JJServiceContent(level)  [NSString stringWithFormat:@"%@%@%@",JJWebHeaderHost,@"serviceinfo.html?level=",level]

	//育婴师服务协议 //龚慧娴 12-6 16:38
	///html/protocol_yuying.html?citycode=103212  这个是育婴师的
#define JJYuyingSkillerProtocolURL   [NSString stringWithFormat:@"%@%@",JJWebHeaderHost,@"protocol_yuying.html"]

//优惠券使用规则
#define JJCouponRuleUrl  [NSString stringWithFormat:@"%@coupon_rule.html",JJWebHeaderHost]

// 认证信息 http://xiangwen.t.jjys168.com/html/approveinfo.html?yuesao_id=95
#define JJCertainInfoUrl(yuesao_id)   [NSString stringWithFormat:@"%@%@%@",JJWebHeaderHost,@"approveinfo.html?yuesao_id=",(yuesao_id)]

	///MARK: -育婴师认证信息
//http://m.jjys168.com/html/yuyin_approveinfo.html?skiller_id=1
#define JJYuyingSkillerCertainInfoURL(skiller_id) [NSString stringWithFormat:@"%@%@%@",JJWebHeaderHost,@"yuyin_approveinfo.html?skiller_id=",(skiller_id)]

// 服务介绍
#define JJServiceURL     [NSString stringWithFormat:@"%@service_advantage.html",JJWebHeaderHost]
//活动专区页面
#define JJActivityURL   [NSString stringWithFormat:@"%@activity_list.html",JJWebHeaderHost]

/**  资讯站  */
#define JJInformationNewsURL   @"https://m.jjys168.com/a/index.html"

/**  短期月子服务  */
#define JJYSShortTermServiceURL  [NSString stringWithFormat:@"%@short_term_service.html",JJWebHeaderHost]

 /** 催乳服务介绍*/
#define JJYSCuiruServiceShowURL  [NSString stringWithFormat:@"%@cuiru_service.html",JJWebHeaderHost]

///MARK: -培训招生 http://m.loc.jjys168.com/school/index.html
//http://m.jjys168.com/school/index.html
#define JJYSTrainURL   @"http://m.jjys168.com/school/index.html"

//套餐介绍
#define JJYS_Service_Introduce_URL  [NSString stringWithFormat:@"%@service_introduce.html",JJWebHeaderHost]

//品质保障
#define JJYS_Quality_Guarantee_URL   [NSString stringWithFormat:@"%@quality_guarantee.html",JJWebHeaderHost]

//专业实力
#define JJYS_Strength_URL  [NSString stringWithFormat:@"%@strength.html",JJWebHeaderHost]

//宝妈心声
#define JJYS_User_Comment_URL  [NSString stringWithFormat:@"%@user_comment.html",JJWebHeaderHost]


//  URL = IP+参数
#pragma mark-----接口参数和方法列表-----------------
FOUNDATION_EXTERN NSString *const KMethodName;         //方法名
FOUNDATION_EXTERN NSString *const KYuesaoIndex;        //月嫂列表
FOUNDATION_EXTERN NSString *const KVersion;            //版本key
FOUNDATION_EXTERN NSString *const KVsionValue;         //版本value
FOUNDATION_EXTERN NSString *const KPlatform ; //平台key
FOUNDATION_EXTERN NSString *const KPlatformValueIOS ; //平台value
FOUNDATION_EXTERN NSString *const KCityCode ; ///城市代码
FOUNDATION_EXTERN NSString *const KList_order;         //排序 key
FOUNDATION_EXTERN NSString *const KMobile;             //手机号
FOUNDATION_EXTERN NSString *const KCode;               //校验码
FOUNDATION_EXTERN NSString *const KYuchanqi;           //预产期
FOUNDATION_EXTERN NSString *const KSmsLoginUser;       //用户端登录校验
FOUNDATION_EXTERN NSString *const KSign;               //动态签名
FOUNDATION_EXTERN NSString *const KSmsCheckUser;       //短信校验
FOUNDATION_EXTERN NSString *const KPredict_day;        //预产期
FOUNDATION_EXTERN NSString *const KPredict_day_more;   //预产期后有档期
FOUNDATION_EXTERN NSString *const kRand ;
FOUNDATION_EXTERN NSString *const kJson ;
FOUNDATION_EXTERN NSString *const kSign ;
FOUNDATION_EXTERN NSString *const kRefer_id ; //前一张订单的order_id
FOUNDATION_EXTERN NSString *const kSkiller_id ; ///育婴师的id
FOUNDATION_EXTERN NSString *const kKeyword ;
FOUNDATION_EXTERN NSString *const KExperience;         //经验
FOUNDATION_EXTERN NSString *const KLevel ; //等级
FOUNDATION_EXTERN NSString *const KYear;               //年龄
FOUNDATION_EXTERN NSString *const KRegion;             //籍贯
FOUNDATION_EXTERN NSString *const KYuesaoView;         //月嫂详情页
FOUNDATION_EXTERN NSString *const kOrigin_id ;//来源
FOUNDATION_EXTERN NSString *const KYuesao_id;          //月嫂ID
FOUNDATION_EXTERN NSString *const KYuesaoHome;         //首页
FOUNDATION_EXTERN NSString *const KUser_id;            //用户ID
FOUNDATION_EXTERN NSString *const kref_user_id ; ///评论用户的id
FOUNDATION_EXTERN NSString *const KUserName ; //用户名
FOUNDATION_EXTERN NSString *const KYuesaoAbout;        //关于页面
FOUNDATION_EXTERN NSString *const KNickname;           // 昵称
FOUNDATION_EXTERN NSString *const KArea ; //地区
FOUNDATION_EXTERN NSString *const KName ; //名字
FOUNDATION_EXTERN NSString *const KAddress;            //地址
FOUNDATION_EXTERN NSString *const KProvice;            //省份
FOUNDATION_EXTERN NSString *const KCity;               //城市
FOUNDATION_EXTERN NSString *const KTown;               //镇区
FOUNDATION_EXTERN NSString *const KDefault;            //默认
FOUNDATION_EXTERN NSString *const KAddress_id;         //地址ID
FOUNDATION_EXTERN NSString *const KAddressUpdate;      //编辑地址
FOUNDATION_EXTERN NSString *const KAddressInfo;        //用户地址详情
FOUNDATION_EXTERN NSString *const KAddressAdd;         //添加地址
FOUNDATION_EXTERN NSString *const KAddressDefault;     //默认地址
FOUNDATION_EXTERN NSString *const KAddressLast; //最后一条
FOUNDATION_EXTERN NSString *const KAddressList;        //地址列表
FOUNDATION_EXTERN NSString *const KYuesaoSchedule;     //月嫂档期
FOUNDATION_EXTERN NSString *const KAddressAreainfo;    //地区信息
FOUNDATION_EXTERN NSString *const KYuesaoCommentList;  //月嫂评论列表
FOUNDATION_EXTERN NSString *const kForce_desc;         //列表排序[1降序,0升序]
FOUNDATION_EXTERN NSString *const kParentid;           //上级地址
FOUNDATION_EXTERN NSString *const kYuesaoCommentInsert;//对月嫂评论
FOUNDATION_EXTERN NSString *const kContent;            //内容
FOUNDATION_EXTERN NSString *const kImage;              //对月嫂评论图片
FOUNDATION_EXTERN NSString *const kOrder_id;           //订单id
FOUNDATION_EXTERN NSString *const kYuesaoScoreInsert;  //对月嫂进行评分
FOUNDATION_EXTERN NSString *const kScore;              //主要分数
FOUNDATION_EXTERN NSString *const kScore_extend;       //各项评分,用逗号分割
FOUNDATION_EXTERN NSString *const kOrderInsert;         // 对月嫂进行下单接口    
FOUNDATION_EXTERN NSString *const kOrderPayInfo;        //支付信息       
FOUNDATION_EXTERN NSString *const kOrderPayStart;       //订单预支付      
FOUNDATION_EXTERN NSString *const kYuesaoCollectInsert; //对月嫂进行关注
FOUNDATION_EXTERN NSString *const kAppAbout;            //关于家家
FOUNDATION_EXTERN NSString *const kOrderIndex;          //订单列表    
FOUNDATION_EXTERN NSString *const kOrderInfo;           //订单详情    
FOUNDATION_EXTERN NSString *const kOrderWater;          //订单流水    
FOUNDATION_EXTERN NSString *const kYuesaoCollectList;   //月嫂收藏列表    
FOUNDATION_EXTERN NSString *const kYuesaoConfig;        //用户端一次性配置是否强制更新
FOUNDATION_EXTERN NSString *const kSchedule_day;        //预约日期
FOUNDATION_EXTERN NSString *const kNum ;                //宝宝个数
FOUNDATION_EXTERN NSString *const kProduct_id;          //服务id
FOUNDATION_EXTERN NSString *const kRemark;              //其它要求
FOUNDATION_EXTERN NSString *const kCoupon_id_user; //优惠券id
FOUNDATION_EXTERN NSString *const kType;                //支付类型[1定金2尾款3全款]
FOUNDATION_EXTERN NSString *const kService_days ; //
FOUNDATION_EXTERN NSString *const kTag ; // 产品标签
FOUNDATION_EXTERN NSString *const klevel_id ; //等级id
FOUNDATION_EXTERN NSString *const kpkg ;
FOUNDATION_EXTERN NSString *const kos_name;
FOUNDATION_EXTERN NSString *const kos_version ;

FOUNDATION_EXTERN NSString *const kProduct_days ; //服务天数
FOUNDATION_EXTERN NSString *const kUserInfo;                //读取用户信息
FOUNDATION_EXTERN NSString *const kToken;                //用户指纹
FOUNDATION_EXTERN NSString *const kUserLoginWeixin;      //微信登陆
FOUNDATION_EXTERN NSString *const kOpenid_weixin;         //openid_weixin
FOUNDATION_EXTERN NSString *const kUnionid_weixin;         //unionid_weixin
FOUNDATION_EXTERN NSString *const kYuesaoShowList;         //工作风采
FOUNDATION_EXTERN NSString *const kConfigServiceGroup;     //配置文件服务天数
FOUNDATION_EXTERN NSString *const kConfigServiceDay ; // 配置购买天数
FOUNDATION_EXTERN NSString *const kConfigProduct ; //新标准价格

FOUNDATION_EXTERN NSString *const kExpertAskList  ;
FOUNDATION_EXTERN NSString *const kExpertList ;
FOUNDATION_EXTERN NSString *const kExpertAskAdd ;
FOUNDATION_EXTERN NSString *const kOrderPayExpertAsk;
FOUNDATION_EXTERN NSString *const kExpertAskView ;
FOUNDATION_EXTERN NSString *const kHoliday ;
FOUNDATION_EXTERN NSString *const kQid ; //问题id
FOUNDATION_EXTERN NSString *const krole ;
FOUNDATION_EXTERN NSString *const kVideoListCourse ;// 视频列表
FOUNDATION_EXTERN NSString *const kVideoCategory ; //视频类别
FOUNDATION_EXTERN NSString *const kVideoCommentListAction ; //视频评论列表
FOUNDATION_EXTERN NSString *const kVideoCommentAdd ;//视频加评论
FOUNDATION_EXTERN NSString *const kVideoShare ; //视频分享
FOUNDATION_EXTERN NSString *const kVideoView ; //视频详情
FOUNDATION_EXTERN NSString *const kvideo_course_id ; //视频id
FOUNDATION_EXTERN NSString *const kvideo_id ; //视频id
FOUNDATION_EXTERN NSString *const KDay_buy; //套餐
FOUNDATION_EXTERN NSString *const KPhone ; //手机号
FOUNDATION_EXTERN NSString *const KSettle_date ;//预产期
FOUNDATION_EXTERN NSString *const KScene_visit_id ;//渠道id
FOUNDATION_EXTERN NSString *const Kis_buy ;
FOUNDATION_EXTERN NSString *const Kask_id ;
FOUNDATION_EXTERN NSString *const klist_order_revert ; //翻转列表顺序
FOUNDATION_EXTERN NSString *const kanswer_id ;
FOUNDATION_EXTERN NSString * const KPage;//页码
FOUNDATION_EXTERN NSString *const KSize ;//每页数量
FOUNDATION_EXTERN NSString *const kUserInfoUpdate ;//修改用户信息
FOUNDATION_EXTERN NSString *const kHeadphoto ;//头像
FOUNDATION_EXTERN NSString *const kpid  ; //评论id
FOUNDATION_EXTERN NSString *const kPredict_at ;//预产期
FOUNDATION_EXTERN NSString *const kGender ;//性别
FOUNDATION_EXTERN NSString *const kCollect_id ;//收藏数据
FOUNDATION_EXTERN NSString *const kId ;//活动详情
FOUNDATION_EXTERN NSString *const kYuesaoCollectCancel ;//取消关注
FOUNDATION_EXTERN NSString *const kActivityList ;//活动列表
FOUNDATION_EXTERN NSString *const kActivityInfo ;//活动详情
FOUNDATION_EXTERN NSString *const kOrderPrice ;  //订单查价格
FOUNDATION_EXTERN NSString *const kAppShare ;    //月嫂分享
FOUNDATION_EXTERN NSString *const kAddressYuesao ;    //月嫂的籍贯
FOUNDATION_EXTERN NSString *const kchannel ;    //支付渠道
FOUNDATION_EXTERN NSString *const kextra_pay;//是否收取节假日费用
FOUNDATION_EXTERN NSString *const kPredict_day ;    //预产期
FOUNDATION_EXTERN NSString *const kOrderPayCancel ;    //取消订单接口
FOUNDATION_EXTERN NSString *const kOrderShare ;    //订单分享接口
FOUNDATION_EXTERN NSString *const kAppleWelcome ;    //苹果审核状态
FOUNDATION_EXTERN NSString *const kWeixinBind ;    //用户绑定微信
FOUNDATION_EXTERN NSString *const kOpen_id ;    //微信open_id
FOUNDATION_EXTERN NSString *const kplan_id ; ///计划最小id
FOUNDATION_EXTERN NSString *const kCouponList ;    //优惠券列表
FOUNDATION_EXTERN NSString *const kCouponFirsttime ;    //优惠券首次弹窗
FOUNDATION_EXTERN NSString *const kCouponPwChange; //兑换优惠券
FOUNDATION_EXTERN NSString *const kYuesaoSearch ; //月嫂搜索
FOUNDATION_EXTERN NSString *const kAdvertBook ; //预约提交资料
FOUNDATION_EXTERN NSString *const kOrderScheduteCheck ;//下单档期检测
FOUNDATION_EXTERN NSString *const kcategory_id ;
FOUNDATION_EXTERN NSString *const kMid ; ///mid
FOUNDATION_EXTERN NSString *const kID ; /// id
FOUNDATION_EXTERN NSString *const kShareRule ; //分享规则 分享的APP
FOUNDATION_EXTERN NSString *const kCount ;    //优惠券评论总条数
FOUNDATION_EXTERN NSString *const kCouponComment ;    //优惠券评论
FOUNDATION_EXTERN NSString *const kCouponServiceGroup ;    //优惠券适用列表
FOUNDATION_EXTERN NSString *const kOrderPayChargeExtra ;//附加费收取
FOUNDATION_EXTERN NSString *const kOrderCheckUnpay ;//检测未付款订单
FOUNDATION_EXTERN NSString *const kAdvertBookMsg ; //报名信息
FOUNDATION_EXTERN NSString *const kDownOrderAddressID ; //下单的地址id
FOUNDATION_EXTERN NSString *const kAdvertBookCount ;//报名人数
FOUNDATION_EXTERN NSString *const kYuesaoVideo ; //月嫂个人视频
FOUNDATION_EXTERN NSString *const kAdminOrderQcode ; //多笔尾款
FOUNDATION_EXTERN NSString *const kProductReorder ; //续单时产品单价
FOUNDATION_EXTERN NSString *const kConfigReorder ; //续单天数列表
FOUNDATION_EXTERN NSString *const  kHolidayCheck ; //检查节假日
FOUNDATION_EXTERN NSString *const kOrderInsertCuiru ; //催乳服务下单
FOUNDATION_EXTERN NSString *const kOrderPriceCuiru ; //催乳价格
FOUNDATION_EXTERN NSString *const kConfigProductCuiru ; //催乳服务配置信息
FOUNDATION_EXTERN NSString *const kArticleCategoryList ; ///文章分类
FOUNDATION_EXTERN NSString *const kArticleList  ;  ///文章列表
FOUNDATION_EXTERN NSString *const kArticleInfo ;///文章详情

FOUNDATION_EXTERN NSString *const kSkillerYuyingIndex ; ///育婴师列表
FOUNDATION_EXTERN NSString *const kSkillerYuyingView ; ///育婴师详情
FOUNDATION_EXTERN NSString *const kOrderInsertYuying ; /// 育婴师下单
FOUNDATION_EXTERN NSString *const kOrderPriceYuying ; ///育婴师下单价格
FOUNDATION_EXTERN NSString *const kOrderPayInfoYuying ; /// 育婴师支付信息
FOUNDATION_EXTERN NSString *const kOrderPayYuying ; ///育婴师支付佣金
FOUNDATION_EXTERN NSString *const kOrderPayPlanList ; ///育婴师月供列表
FOUNDATION_EXTERN NSString *const kOrderPayYuyingSalay ; ///育婴师工资
FOUNDATION_EXTERN NSString *const kSkillerYuyingSchedule ;//育婴师档期
FOUNDATION_EXTERN NSString *const kSkillerYuyingSearch ; ///育婴师搜索
FOUNDATION_EXTERN NSString *const kConfigCity ; //配置城市
FOUNDATION_EXTERN NSString *const kCorpList; // 加盟商
FOUNDATION_EXTERN NSString *const kYuesaoSchedulePie ;
FOUNDATION_EXTERN NSString *const kYuyingSchedulePie ;
FOUNDATION_EXTERN NSString *const kArticleSearch ;
FOUNDATION_EXTERN NSString *const kAppHello ;
FOUNDATION_EXTERN NSString *const kGuzngzhouComment ; ///优质评论
FOUNDATION_EXTERN NSString *const kUserLoginInfo ;
FOUNDATION_EXTERN NSString *const kArticleNiceList ;

FOUNDATION_EXTERN NSString *const KUserShopniu;       //远程登陆shopniu系统

