//
//  UIBarButtonItem+Extension.m
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                  highlightedImageName:(NSString *)highlightedImageName
                                target:(id)target
                                action:(SEL)action
{
    UIButton *Button = [[UIButton alloc] init];
    [Button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [Button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    Button.size = Button.currentBackgroundImage.size;  //使按钮的大小等于当前背景图片的大小
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:Button];
}

@end
