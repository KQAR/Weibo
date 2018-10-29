//
//  AccountTool.h
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "AccessTokenParam.h"

@class Account;

NS_ASSUME_NONNULL_BEGIN

@interface AccountManager : BaseManager

/**
 *  存储账号
 */
+ (void)save:(Account *)account;

/**
 *  读取账号
 */
+ (Account *)account;

/**
 *  获得accesToken
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)accessTokenWithParam:(AccessTokenParam *)param success:(void (^)(Account *account))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
