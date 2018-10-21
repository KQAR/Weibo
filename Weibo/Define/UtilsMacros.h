//
//  UtilsMacros.h
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

#ifdef DEBUG //调试状态，打开LOG功能
#define JRLog(...) NSLog(__VA_ARGS__)
#else //发布状态，关闭LOG功能
#define JRLog(...)
#endif

/** 解决打印JSON的时候，NSLog控制台显示不完整 **/
#define CLog(format, ...)  NSLog(format, ## __VA_ARGS__)
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#endif /* UtilsMacros_h */
