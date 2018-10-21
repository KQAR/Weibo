//
//  ControllerTool.h
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//
/** 负责控制器的 **/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ControllerTool : NSObject
/** 判断是否跳转新特性控制器 **/
+ (void)chooseRootViewController;

@end

NS_ASSUME_NONNULL_END
