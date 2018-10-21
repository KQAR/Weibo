//
//  UIBarButtonItem+Extension.h
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)

/**
 添加导航栏图片按钮

 @param imageName 默认情况下的按钮图片
 @param hightlightedImageName 点击下的高亮图片
 @param target 目标对象
 @param action 点击方法
 @return 返回一个导航栏d图片按钮
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                  highlightedImageName:(NSString *)hightlightedImageName
                                target:(id)target
                                action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
