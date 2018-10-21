//
//  JRTabBar.m
//  Weibo
//
//  Created by he on 2018/10/11.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "JRTabBar.h"

@interface JRTabBar()
@property (nonatomic, weak) UIButton *plusButton;
@end

@implementation JRTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加加号按钮
        [self setupPlusButton];
    }
    return self;
}

/**
 *  添加加号按钮
 */
- (void)setupPlusButton
{
    UIButton *plusButton = [[UIButton alloc] init];
    // 设置背景
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    // 设置图标
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    // 添加
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

// 按钮点击
- (void)plusClick
{
    // 通知代理
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.tabBarDelegate tabBarDidClickedPlusButton:self];
    }
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //  设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
    
    //  设置plusButton的frame
    [self setupPlusButtonFrame];
}

/**
 *  设置所有tabbarButton的frame
 */
- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    // 遍历所有button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

- (void)setupPlusButtonFrame
{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

/**
 设置某个按钮的frame

 @param tabBarButton 需要设置的按钮
 @param index 按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    // 计算button的尺寸
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    if (index >= 2) {
        tabBarButton.x = buttonW * (index +1);
    } else {
        tabBarButton.x = buttonW * index;
    }
    tabBarButton.y = 0;
}

@end
