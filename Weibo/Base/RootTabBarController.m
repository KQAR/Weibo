//
//  RootTabBarController.m
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "RootNavigationViewController.h"
#import "JRTabBar.h"
#import "ComposeViewController.h"

@interface RootTabBarController () <JRTabBarDelegate>

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加所有子控制器
    [self addAllChildViewController];
    // 创建自定义tabbar
    [self addCustomTabBar];
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    JRTabBar *customTabBar = [[JRTabBar alloc] init];
    // 设置代理
    customTabBar.tabBarDelegate = self;
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

/**
 *  添加所有子控制器
 */
- (void)addAllChildViewController
{
    //添加子控制器
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addOneChildViewController:home title:@"首页" imageName:@"icon_tabbar_homepage" selectedImageName:@"icon_tabbar_homepage_selected"];
    
    MessageViewController *message = [[MessageViewController alloc] init];
    [self addOneChildViewController:message title:@"消息" imageName:@"icon_tabbar_merchant_normal" selectedImageName:@"icon_tabbar_merchant_selected"];
    
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addOneChildViewController:discover title:@"发现" imageName:@"icon_tabbar_onsite" selectedImageName:@"icon_tabbar_onsite_selected"];
    
    ProfileViewController *me = [[ProfileViewController alloc] init];
    [self addOneChildViewController:me title:@"我" imageName:@"icon_tabbar_mine" selectedImageName:@"icon_tabbar_mine_selected"];
    
    //改变tabbarController文字选中颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:10]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:RGB(47, 173, 159)} forState:UIControlStateSelected];
}

/**
 添加一个子控制器，并设置标题，tabbar图片
 */
- (void)addOneChildViewController:(UIViewController *)childController
                            title:(NSString *)title
                        imageName:(NSString *)imagename
                selectedImageName:(NSString *)selectedImageName
{
    //不要在这里设置控制器的视图（如：颜色）这会在第一次进去程序时创建四个导航控制器的view。记住：用户用到一个加载一个view 而且这会导致后面的导航控制器视图无法设置。
    childController.title = title;
    childController.tabBarItem.badgeValue = @"10";
    childController.tabBarItem.image = [UIImage imageNamed:imagename];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    //声明这张图别渲染，用原图
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectedImage;
    RootNavigationViewController *nav = [[RootNavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

#pragma mark — JRTabBarDelegate
- (void)tabBarDidClickedPlusButton:(JRTabBar *)tabBar
{
    // 弹出发微博控制器
    ComposeViewController *compose = [[ComposeViewController alloc] init];
    RootNavigationViewController *nav = [[RootNavigationViewController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
