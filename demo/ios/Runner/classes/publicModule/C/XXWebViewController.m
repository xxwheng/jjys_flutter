//
//  XXWebViewController.m
//  JJYSPlusPlus
//
//  Created by dengxf on 16/6/8.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "XXWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

@interface XXWebViewController () <WKNavigationDelegate>

@property (strong,nonatomic) WKWebView *webView;

@property (strong,nonatomic) UIViewController *controller;

@property (nonatomic,strong) NSString *navTitle;

@end

@implementation XXWebViewController


- (instancetype)initWithMethodType:(JJWebRequestType )requestType parameters:(NSDictionary *)parametersDict  url:(NSString *)url  title:(NSString *)title
{
	self = [super init];
	if (self) {
		self.navTitle = title;
		self.view.backgroundColor = JJBlackColor;
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
		WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavBarHeight, KWIDTH, KHIGHT-NavBarHeight) configuration:config];
		
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [webView setContentMode:UIViewContentModeRedraw];
        [webView setOpaque:YES];
        
		webView.backgroundColor = [UIColor whiteColor];

		NSString *body = [NSString parametersStringWithDict: parametersDict];

		if (requestType == JJWebRequestTypeGET) {
			url = [NSString stringWithFormat:@"%@?%@",url,body];
		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
		}else{
			NSURL *requestUrl = [NSURL URLWithString: url];
			NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: requestUrl];
			[request setHTTPMethod: @"POST"];
			[request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
			[webView loadRequest: request];
		}
		adjustsScrollViewInsets_NO(webView.scrollView,self);
//		webView.height -= BottomHeight;

		[self.view addSubview:webView];
		self.webView = webView;
	}
	return self;
}


- (instancetype)initWithWebViewControllerWithWebViewUrl:(NSString *)url title:(NSString *)title FromController:(UIViewController *)controller{
    if (self = [super init]) {
		self.navTitle = title;
        self.view.backgroundColor = kBgColor;
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavBarHeight, KWIDTH, KHIGHT-NavBarHeight) configuration:config];
        
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [webView setContentMode:UIViewContentModeRedraw];
        [webView setOpaque:YES];
        
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url.wgb_mapURL]]];

		adjustsScrollViewInsets_NO(webView.scrollView,self);
//		webView.height -= BottomHeight;

		NSLog(@"H5外链: ---> \n%@\n",url.wgb_mapURL);
	   [self.view addSubview:webView];

        self.webView = webView;
        self.controller = controller;

        if ([controller isKindOfClass:NSClassFromString(@"XXMyProfileViewController")]) {
            [self setupNavBarPopButton];
        }
    }
    return self;
}

//母婴商城额外添加另一userid和token
- (instancetype)initWithShopniuWebViewWithUrl:(NSString *)url title:(NSString *)title FromController:(UIViewController *)controller {
	if (self = [super init]) {
		self.navTitle = title;
		self.view.backgroundColor = kBgColor;
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavBarHeight, KWIDTH, KHIGHT-NavBarHeight) configuration:config];
        
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [webView setContentMode:UIViewContentModeRedraw];
        [webView setOpaque:YES];
        
		
		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url.shopniu_mapURL]]];

		adjustsScrollViewInsets_NO(webView.scrollView,self);
//		webView.height -= BottomHeight;

		NSLog(@"H5外链: ---> \n%@\n",url.shopniu_mapURL);
		[self.view addSubview:webView];
		self.webView = webView;
		self.controller = controller;

		if ([controller isKindOfClass:NSClassFromString(@"XXMyProfileViewController")]) {
			[self setupNavBarPopButton];
		}
	}
	return self;
}

//无需传参web
- (instancetype)initNoParamWebWithUrl:(NSString *)url title:(NSString *)title FromController:(UIViewController *)controller {
	if (self = [super init]) {
		self.navTitle = title;
		self.view.backgroundColor = kBgColor;
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavBarHeight, KWIDTH, KHIGHT-NavBarHeight) configuration:config];
        
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [webView setContentMode:UIViewContentModeRedraw];
        [webView setOpaque:YES];
        

		NSString *urlStr = [NSString stringWithFormat:@"%@?citycode=%@&_corp_id=%@", url,[JJYSLoginTool defaultCityCode],[JJYSLoginTool getCorpId]];
		NSString *resUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: resUrl]]];

		adjustsScrollViewInsets_NO(webView.scrollView,self);
//		webView.height -= BottomHeight;

		NSLog(@"H5外链: ---> \n%@\n",resUrl);
		[self.view addSubview:webView];
		self.webView = webView;
		self.controller = controller;

		if ([controller isKindOfClass:NSClassFromString(@"XXMyProfileViewController")]) {
			[self setupNavBarPopButton];
		}
	}
	return self;
}


- (void)setNavTitle:(NSString *)navTitle{
	_navTitle = navTitle;
	[self setupBasicSettingsWithNavBarTitle: navTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController.navigationBar setTitleTextAttributes:
	 @{NSFontAttributeName:[UIFont systemFontOfSize:20],
	   NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
	self.webView.navigationDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear: animated];
}

- (void)backToLastController {
    if ([NSStringFromClass([self.controller class]) isEqualToString:@"XXMyProfileViewController"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [UIApplication sharedApplication].statusBarHidden = YES;
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end


