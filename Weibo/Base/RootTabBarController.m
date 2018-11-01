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
#import "UserManager.h"
#import "Account.h"
#import "AccountManager.h"

@interface RootTabBarController () <JRTabBarDelegate, UITabBarControllerDelegate>
@property (nonatomic, weak) HomeViewController *home;
@property (nonatomic, weak) MessageViewController *message;
@property (nonatomic, weak) ProfileViewController *profile;
@property (nonatomic, weak) UIViewController *lastSelectedViewContoller;
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    // 添加所有子控制器
    [self addAllChildViewController];
    // 创建自定义tabbar
    [self addCustomTabBar];
    // 利用定时器获得用户的未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    UIViewController *vc = [viewController.viewControllers firstObject];
    if ([vc isKindOfClass:[HomeViewController class]]) {
        if (self.lastSelectedViewContoller == vc) {
            [self.home refresh:YES];
        } else {
            [self.home refresh:NO];
        }
    }

    self.lastSelectedViewContoller = vc;
}

- (void)getUnreadCount
{
    // 1.请求参数
    UnreadCountParam *param = [UnreadCountParam param];
    param.uid = [AccountManager account].uid;
    
    // 2.获得未读数
    [UserManager unreadCountWithParam:param success:^(UnreadCountResult *result) {
        // 显示微博未读数
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", (result.status - 1011)];
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        } else {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        } else {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        // 在AppIcon图标上显示所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        JRLog(@"总未读数--%d", result.totalCount);
    } failure:^(NSError *error) {
        JRLog(@"获得未读数失败---%@", error);
    }];
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
    [self addOneChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    self.lastSelectedViewContoller = home;
    
    MessageViewController *message = [[MessageViewController alloc] init];
    [self addOneChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addOneChildViewController:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self addOneChildViewController:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
    
    //改变tabbarController文字选中颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:10]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:RGB(244, 109, 9)} forState:UIControlStateSelected];
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
    childController.tabBarItem.image = [UIImage imageNamed:imagename];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    //声明这张图别渲染，用原图
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectedImage;
    RootNavigationViewController *nav = [[RootNavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

#pragma mark - JRTabBarDelegate

- (void)tabBarDidClickedPlusButton:(JRTabBar *)tabBar
{
    // 弹出发微博控制器
    ComposeViewController *compose = [[ComposeViewController alloc] init];
    RootNavigationViewController *nav = [[RootNavigationViewController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
