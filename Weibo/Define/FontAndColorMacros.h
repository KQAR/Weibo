//
//  FontAndColorMacros.h
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark ——————————————————————————————— 字体区 ———————————————————————————————
//快捷字体设置
#define JRFont(f) [UIFont systemFontOfSize:f]

#define JRNavigationTitleFont [UIFont systemFontOfSize:18]



#pragma mark ——————————————————————————————— 颜色区 ———————————————————————————————

//随机色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//RGB颜色设置
#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

// APP主题色(橙色)
#define THEMECOLOR RGB(244, 109, 9)

// 原创微博昵称字体
#define StatusOrginalNameFont [UIFont systemFontOfSize:14]
// 原创微博时间字体
#define StatusOrginalTimeFont [UIFont systemFontOfSize:12]
// 原创微博来源字体
#define StatusOrginalSourceFont StatusOrginalTimeFont
// 原创微博正文字体
#define StatusOrginalTextFont [UIFont systemFontOfSize:15]

// 转发微博昵称字体
#define StatusRetweetedNameFont StatusOrginalNameFont
// 转发微博正文字体
#define StatusRetweetedTextFont StatusOrginalTextFont

#endif /* FontAndColorMacros_h */
