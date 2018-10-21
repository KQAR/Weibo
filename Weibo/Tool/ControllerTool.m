//
//  ControllerTool.m
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "ControllerTool.h"
#import "RootTabBarController.h"
#import "NewFeatureViewController.h"

@implementation ControllerTool

+ (void)chooseRootViewController
{
    //-----如何知道第一次使用这个版本，比较上一次使用情况
    NSString *versionKey = @"CFBundleVersion";
    
    //-----从沙盒中取出上次存储的软件版本号（取出用户上次的使用记录）
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    //-----获取当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    //-----比较两个版本号，版本号不一致说明第一次使用
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示主界面
        window.rootViewController  = [[RootTabBarController alloc] init];
    } else {
        // 显示版本新特性
        window.rootViewController = [[NewFeatureViewController alloc] init];
        
        //-----存储这次使用的软件版本号
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}

@end
