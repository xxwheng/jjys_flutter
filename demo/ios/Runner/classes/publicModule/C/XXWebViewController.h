//
//  XXWebViewController.h
//  JJYSPlusPlus
//
//  Created by dengxf on 16/6/8.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,JJWebRequestType) {
	JJWebRequestTypeGET  =  0,
	JJWebRequestTypePOST
};

@interface XXWebViewController : XXBaseViewController

/**
 *  web界面
 *
 *  @param url   web链接地址
 *  @param title 界面导航栏标题
 */

- (instancetype)initWithWebViewControllerWithWebViewUrl:(NSString *)url title:(NSString *)title FromController:(UIViewController *)controller;

//母婴商城
- (instancetype)initWithShopniuWebViewWithUrl:(NSString *)url title:(NSString *)title FromController:(UIViewController *)controller;

//无需传参web
- (instancetype)initNoParamWebWithUrl:(NSString *)url title:(NSString *)title FromController:(UIViewController *)controller;
/**
 统一网页接口

 @param requestType 请求的方法 GET或者POST
 @param parametersDict 参数字典
 @param url 网址
 @param title 标题
 @return 网页实例
 */
- (instancetype)initWithMethodType:(JJWebRequestType )requestType
						parameters:(NSDictionary *)parametersDict
							   url:(NSString *)url
							 title:(NSString *)title ;

@end
