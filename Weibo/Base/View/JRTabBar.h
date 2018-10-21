//
//  JRTabBar.h
//  Weibo
//
//  Created by he on 2018/10/11.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRTabBar;

@protocol JRTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(JRTabBar *)tabBar;

@end

NS_ASSUME_NONNULL_BEGIN

@interface JRTabBar : UITabBar
@property (nonatomic, weak) id<JRTabBarDelegate> tabBarDelegate;
@end

NS_ASSUME_NONNULL_END
