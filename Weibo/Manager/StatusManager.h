//
//  StatusTool.h
//  Weibo
//
//  Created by he on 2018/10/23.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManager.h"
#import "HomeStatusesParam.h"
#import "HomeStatusesResult.h"
#import "SendStatusParam.h"
#import "SendStatusResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatusManager : BaseManager

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)homeStatusesWithParam:(HomeStatusesParam *)param
                      success:(void (^)(HomeStatusesResult *result))success
                      failure:(void (^)(NSError *error))failure;

/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)sendStatusWithParam:(SendStatusParam *)param
                    success:(void (^)(SendStatusResult *result))success
                    failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
