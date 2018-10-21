//
//  AccountTool.h
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;

NS_ASSUME_NONNULL_BEGIN

@interface AccountTool : NSObject

/**
 *  存储账号
 */
+ (void)save:(Account *)account;

/**
 *  读取账号
 */
+ (Account *)account;

@end

NS_ASSUME_NONNULL_END
