//
//  Account.h
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//
//         /** 账号模型 **/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject <NSCoding>
/** string 用于调用access_token,接口获取授权后的access token **/
@property (nonatomic, copy) NSString *access_token;

/** string access_token的生命周期，单位是秒数 **/
@property (nonatomic, copy) NSString *expires_in;

/** 过期时间 **/
@property (nonatomic, strong) NSDate *expires_time;

/** string 当前授权用户的UID **/
@property (nonatomic, copy) NSString *uid;

/** string 用户昵称 **/
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
