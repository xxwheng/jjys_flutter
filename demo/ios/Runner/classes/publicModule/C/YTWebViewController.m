//
//  YTWebViewController.m
//  YTWebKit
//
//  Created by Wangguibin on 2018/3/22.
//  Copyright © 2018年 wheng. All rights reserved.
//

#import "YTWebViewController.h"
#import <WebKit/WKNavigationDelegate.h>
#import <WebKit/WKWebViewConfiguration.h>

@interface YTWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong)WKWebView *webView;

@property (nonatomic, strong)NSMutableURLRequest *request;

@property (nonatomic, strong)UIButton *callBackButton;

@property (nonatomic, strong)UIButton *popButton;

@property (nonatomic, strong)UIView *customView;


@property (nonatomic, strong)WKWebViewConfiguration *webConfiguration;

/**
 进度条
 */
@property (nonatomic, strong)UIProgressView *progressView;

@end

static NSString *const YTEstimatedProgressKeyPath = @"estimatedProgress";
static NSString *const YTTitleKeyPath = @"title";

@implementation YTWebViewController

- (instancetype)init {
	self = [super init];
	if (self) {
		[self setupConfig];
	}
	return self;
}

- (instancetype)initWithURL:(NSURL *)url {
	self = [super init];
	if (self) {
		_url = [self cleanURL:url];
		[self setupConfig];
	}
	return self;
}

- (instancetype)initWithURLString:(NSString *)urlString {
	self = [super init];
	if (self) {
		_url = [self cleanURL:[NSURL URLWithString:urlString]];
		[self setupConfig];
	}
	return self;
}

- (void)loadView {
	[super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self.request setURL:self.url];
    
//	[self.webView setDataDetectorTypes:UIDataDetectorTypeAll];

	[self.webView loadRequest:self.request];

	[self.view addSubview:self.webView];

	UIBarButtonItem *customBitem = [[UIBarButtonItem alloc] initWithCustomView:self.customView];
	self.navigationItem.leftBarButtonItem = customBitem;

	self.navigationItem.title = @"Loading...";

	NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
	self.navigationController.navigationBar.titleTextAttributes = dic;
}

- (void)upDateLeftNavigationBarButton {

	if ([self.webView canGoBack]) {
		self.navigationController.interactivePopGestureRecognizer.enabled = NO;
		[self.popButton setHidden:NO];
	} else {
		self.navigationController.interactivePopGestureRecognizer.enabled = YES;
		[self.popButton setHidden:YES];
	}
}

- (void)backButtonAction {
	if ([self.webView canGoBack]) {
		[self.webView goBack];
	} else {
		[self closeButtonAction];
	}
}

- (void)closeButtonAction {
	if (![JJYSLoginTool getUid]) {
	}
    if ([self presentationController]) {
        [self dismissViewControllerAnimated:true completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - SetupConfig
- (void)setupConfig {
	[self setIsShowWebTitle:YES];
    [self setIsShowProgress:YES];
    //默认进度条颜色(red)
    [self setProgressTintColor:[UIColor redColor]];
    //默认进度条背景色
    [self setProgressTrackColor:[UIColor clearColor]];
}

- (NSURL *)cleanURL:(NSURL *)url {
	if (url.scheme.length == 0) {
		url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[url absoluteString]]];
	}
	return url;
}

- (void)didFinishLoad_UpdateNavBar {
	[self upDateLeftNavigationBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKWebViewDelegate

//页面加载失败调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {

    [self didFinishLoad_UpdateNavBar];

    //YTWKWebDelegate    didFailLoad
    if ([self.delegate respondsToSelector:
         @selector(yt_webView:didFailLoad:withError:)]) {
        [self.delegate yt_webView:webView didFailLoad:webView.URL withError:error];
    }
}

//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    [self didFinishLoad_UpdateNavBar];

    //YTWKWebDelegate didFinishedLoad
    if ([self.delegate respondsToSelector:
         @selector(yt_webView:didFinishedLoad:)]) {
        [self.delegate yt_webView:webView didFinishedLoad:webView.URL];
    }

	if (_isShowWebTitle) {
        self.navigationItem.title = webView.title;
	}
}

//页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self didFinishLoad_UpdateNavBar];

    if ([self.delegate respondsToSelector:@selector(yt_webView:didStartLoad:)]) {
        [self.delegate yt_webView:webView didStartLoad:webView.URL];
    }
}

// 在发送请求之前,决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //返回结果(默认 Allow)
    if ([self.delegate respondsToSelector:@selector(yt_webView:shouldStartLoad:)]) {

        BOOL delegateRes = [self.delegate yt_webView:webView shouldStartLoad:webView.URL];
        if (delegateRes) {
            decisionHandler(WKNavigationActionPolicyAllow);
        } else {
            decisionHandler(WKNavigationActionPolicyCancel);
        }
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

    ///MARK: Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:YTEstimatedProgressKeyPath]) {
        //进度条监听回调
        CGFloat progress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (progress == 1) {
            [self.progressView setHidden:YES];
            [self.progressView setProgress:0 animated:NO];
        } else {
            [self.progressView setHidden:NO];
            [self.progressView setProgress:progress animated:YES];
        }
    } else if ([keyPath isEqualToString:YTTitleKeyPath]) {
        NSString *title = [change objectForKey:NSKeyValueChangeNewKey];
        self.navigationItem.title = title;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setUrl:(NSURL *)url{
	if (self.url == url) {
		return;
	}
	_url = [self cleanURL:url];


}

- (void)setUrlString:(NSString *)urlString{
	_urlString = urlString;
	_url = [self cleanURL:[NSURL URLWithString:urlString]];

}

//
- (UIView *)customView {
	if (!_customView) {
		_customView = [[UIView alloc] init];
		[_customView setFrame:CGRectMake(-15, 0, 88, 44)];
		[_customView addSubview:self.callBackButton];
		[_customView addSubview:self.popButton];
	}
	return _customView;
}

//直接返回
- (UIButton *)popButton {
	if (!_popButton) {
		_popButton = [[UIButton alloc] init];
		[_popButton setFrame:CGRectMake(38, 0, 44, 44)];
		[_popButton setTitle:@"关闭" forState: UIControlStateNormal];
		[_popButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
		[_popButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
		[_popButton setHidden:YES];
	}
	return _popButton;
}

//返回一层
- (UIButton *)callBackButton {
	if (!_callBackButton) {
		_callBackButton = [[UIButton alloc] init];
		[_callBackButton setFrame:CGRectMake(0, 0, 40, 44)];
		[_callBackButton setTitle:@"返回" forState: UIControlStateNormal];
		[_callBackButton setImage:[UIImage imageNamed:@"navRuturnBtn"] forState:UIControlStateNormal];
		[_callBackButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 6)];
		[_callBackButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
		[_callBackButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
		[_callBackButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
	}
	return _callBackButton;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        [_progressView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
        [_progressView setTintColor:self.progressTintColor];
        [_progressView setTrackTintColor:self.progressTrackColor];
    }
    return _progressView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.webConfiguration];
        [_webView setNavigationDelegate:self];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [_webView setContentMode:UIViewContentModeRedraw];
        [_webView setOpaque:YES];
        if (self.isShowProgress) {
            //监听进度
            [_webView addObserver:self forKeyPath:YTEstimatedProgressKeyPath options:NSKeyValueObservingOptionNew context:nil];
        }

        if (self.isShowWebTitle) {
            //web标题
            [_webView addObserver:self forKeyPath:YTTitleKeyPath options:NSKeyValueObservingOptionNew context:nil];
        }
        NSLog(@"Init WebView");
    }
    return _webView;
}


- (WKWebViewConfiguration *)webConfiguration {
    if (!_webConfiguration) {
        _webConfiguration = [[WKWebViewConfiguration alloc] init];
    }
    return _webConfiguration;
}

- (NSMutableURLRequest *)request {
	if (!_request) {
		_request = [[NSMutableURLRequest alloc] init];
	}
	return _request;
}

@end
