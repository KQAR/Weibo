//
//  UserManager.h
//  Weibo
//
//  Created by he on 2018/10/23.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "UserInfoParam.h"
#import "UserInfoResult.h"
#import "UnreadCountParam.h"
#import "UnreadCountResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : BaseManager

/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)userInfoWithParam:(UserInfoParam *)param
                  success:(void (^)(UserInfoResult *result))success
                  failure:(void (^)(NSError *error))failure;

+ (void)unreadCountWithParam:(UnreadCountParam *)param
                     success:(void (^)(UnreadCountResult *result))success
                     failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
