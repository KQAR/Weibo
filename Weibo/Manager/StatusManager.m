//
//  StatusTool.m
//  Weibo
//
//  Created by he on 2018/10/23.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "StatusManager.h"

@implementation StatusManager

+ (void)homeStatusesWithParam:(HomeStatusesParam *)param
                      success:(void (^)(HomeStatusesResult *))success
                      failure:(void (^)(NSError *))failure
{
    [self getWithUrl:URL_NewStatus param:param resultClass:[HomeStatusesResult class] success:success failure:failure];
}

+ (void)sendStatusWithParam:(SendStatusParam *)param
                    success:(void (^)(SendStatusResult *))success
                    failure:(void (^)(NSError *))failure
{
    [self postWithUrl:URL_Update param:param resultClass:[SendStatusResult class] success:success failure:failure];
}

@end
