//
//  RootNavigationViewController.m
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "RootNavigationViewController.h"

@interface RootNavigationViewController ()

@end

@implementation RootNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 第一次使用这个类的时候调用一次
 */
+ (void)initialize
{
    //设置导航栏主题
    [self setupNavgationBarTheme];
    //设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

+ (void)setupNavgationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
    textDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    textDic[NSFontAttributeName] = JRFont(15);
    //设置阴影取消
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeZero];
    textDic[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textDic];
}

+ (void)setupBarButtonItemTheme
{
    //通过appearance对象能修改整个项目中的UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    //设置普通状态的文字属性
    NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
    textDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textDic[NSFontAttributeName] = JRFont(15);
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeZero];
    textDic[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textDic forState:UIControlStateNormal];
    
    //设置高亮状态的文字属性
    NSMutableDictionary *highlightTextDic = [NSMutableDictionary dictionaryWithDictionary:textDic];
    highlightTextDic[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highlightTextDic forState:UIControlStateHighlighted];
    
    //设置不可用状态（disable）的文字属性
    NSMutableDictionary *disableTextDic = [NSMutableDictionary dictionaryWithDictionary:textDic];
    disableTextDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextDic forState:UIControlStateDisabled];
}

/**
 拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {  //如果push的不是栈低的控制器（最先push进来的控制器），那么隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        //设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"back_icon" highlightedImageName:@"back_icon" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"close_icon" highlightedImageName:@"close_icon" target:self action:@selector(pop)];
    }
    [super pushViewController:viewController animated:animated]; //这个要放在if判断后面（因为这个是执行push操作，操作之后栈底会增加控制器）
}

- (void)back
{
    JRLog(@"friendSearch------");
    [self popViewControllerAnimated:YES];
}

- (void)pop
{
    JRLog(@"pop--------");
    [self popToRootViewControllerAnimated:YES];
}

@end
