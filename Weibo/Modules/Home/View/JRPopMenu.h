//
//  JRPopMenu.h
//  Weibo
//
//  Created by he on 2018/10/11.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JRPopMenuArrowPositionCenter = 0,
    JRPopMenuArrowPositionLeft = 1,
    JRPopMenuArrowPositionRight = 2
} JRPopMenuArrowPosition;

@class JRPopMenu;

@protocol JRPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(JRPopMenu *)popMenu;
@end

NS_ASSUME_NONNULL_BEGIN

@interface JRPopMenu : UIView
@property (nonatomic, weak) id<JRPopMenuDelegate> delegate;
//设置菜单背景虚化
@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;
//设置菜单箭头位置
@property (nonatomic, assign) JRPopMenuArrowPosition arrowPosition;

/**
 初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 关闭菜单
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
