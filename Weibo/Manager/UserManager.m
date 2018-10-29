//
//  UserManager.m
//  Weibo
//
//  Created by he on 2018/10/23.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (void)userInfoWithParam:(UserInfoParam *)param
                  success:(void (^)(UserInfoResult *))success
                  failure:(void (^)(NSError *))failure
{
    [self getWithUrl:URL_User param:param resultClass:[UserInfoResult class] success:success failure:failure];
}

+ (void)unreadCountWithParam:(UnreadCountParam *)param
                     success:(void (^)(UnreadCountResult *))success
                     failure:(void (^)(NSError *))failure
{
    [self getWithUrl:URL_UnreadCount param:param resultClass:[UnreadCountResult class] success:success failure:failure];
}

@end
