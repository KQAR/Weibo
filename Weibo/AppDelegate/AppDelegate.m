//
//  AppDelegate.m
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "NewFeatureViewController.h"
#import "OAuthViewController.h"
#import "ControllerTool.h"
#import "AccountTool.h"
#import "Account.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置窗口可见
    [self.window makeKeyAndVisible];
    
    //设置窗口的根控制器
    // 获取本地是否有账号信息
    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *filepath = [doc stringByAppendingPathComponent:@"account.plist"];
//    NSDictionary *account = [NSDictionary dictionaryWithContentsOfFile:filepath];

    Account *account = [AccountTool account];
    
    if (account) {
        // 切换控制器
        [ControllerTool chooseRootViewController];
    } else { // 没登录过
        // 到登录页面
        self.window.rootViewController = [[OAuthViewController alloc] init];
    }
    
    // 网络监控
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    // 网络状态改变时调用
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"没有网络（断网）");
//                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
//                break;
//
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"手机自带网络");
//                break;
//
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"WIFI");
//                break;
//
//            default:
//                break;
//        }
//    }];
//    // 开始监控
//    [manager startMonitoring];
    
    return YES;
}




@end
