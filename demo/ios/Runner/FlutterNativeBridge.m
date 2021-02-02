//
//  FlutterNativeBridge.m
//  Runner
//
//  Created by 恒  王 on 2021/2/2.
//

#import "FlutterNativeBridge.h"
#import "CustomNavigationController.h"
#import "XXJJAboutJiaJiaYueSaoViewController.h"
#import "YTWebViewController.h"

@implementation FlutterNativeBridge

+ (void)gotoAboutFromFlutter:(FlutterViewController *)originVC {
    XXJJAboutJiaJiaYueSaoViewController *aboutVC = [[XXJJAboutJiaJiaYueSaoViewController alloc] init];
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController: aboutVC];
    [nav setModalPresentationStyle:UIModalPresentationFullScreen];
    [originVC presentViewController:nav animated:YES completion:NULL];
}

+ (void)gotoArticleWeb:(NSString *)articleId title:(NSString *)title fromFlutter:(FlutterViewController *)originVC {
    NSString *url = [NSString stringWithFormat:@"%@ArticleShow/%@.html",JJWebNewsHost,articleId];
    YTWebViewController *webController =[[YTWebViewController alloc] init];
    webController.urlString = url;
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController: webController];
    [nav setModalPresentationStyle:UIModalPresentationFullScreen];
    [originVC presentViewController:nav animated:YES completion:NULL];
}

@end
