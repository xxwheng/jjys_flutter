//
//  FlutterNativeBridge.h
//  Runner
//
//  Created by 恒  王 on 2021/2/2.
//

#import <Foundation/Foundation.h>
#import <Flutter/FlutterViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlutterNativeBridge : NSObject

+ (void)gotoAboutFromFlutter: (FlutterViewController *)originVC;

+ (void)gotoArticleWeb: (NSString *)articleId title: (NSString *)title fromFlutter: (FlutterViewController *)originVC;

@end

NS_ASSUME_NONNULL_END
