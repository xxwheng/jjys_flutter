//
//  YTWebViewController.h
//  YTWebKit
//
//  Created by Wangguibin on 2018/3/22.
//  Copyright © 2018年 wheng. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>

@protocol YTH5LoginDelegate <NSObject>

@optional

- (void)yt_h5LoginBack;

- (void)yt_h5LoginHandlerWithURL:(NSURL *)url;

@end

@protocol YTWebViewDelegate <NSObject>

@optional
- (BOOL)yt_webView:(WKWebView *)webView shouldStartLoad:(NSURL *)url;

- (void)yt_webView:(WKWebView *)webView didFinishedLoad:(NSURL *)url;

- (void)yt_webView:(WKWebView *)webView didStartLoad:(NSURL *)url;

- (void)yt_webView:(WKWebView *)webView didFailLoad:(NSURL *)url withError:(NSError *)error;

@end



@interface YTWebViewController : UIViewController

@property (nonatomic, weak)id<YTWebViewDelegate> delegate;

@property (nonatomic, copy)NSString *urlString;

@property (nonatomic, strong)NSURL *url;
/**
 show web Element title
 Default is YES.
 */
@property (nonatomic, assign)BOOL isShowWebTitle;


/**
 是否显示进度条
 Default is YES
 */
@property (nonatomic, assign)BOOL isShowProgress;

/**
 进度条颜色
 Default is Red
 */
@property (nonatomic, strong)UIColor *progressTintColor;

/**
 进度条背景色
 Default is Clear
 */
@property (nonatomic, strong)UIColor *progressTrackColor;

@end
