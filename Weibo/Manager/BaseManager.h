//
//  BaseManager.h
//  Weibo
//
//  Created by he on 2018/10/29.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseManager : NSObject

+ (void)getWithUrl:(NSString *)url
             param:(id)param
       resultClass:(Class)resultClass
           success:(void (^)(id))success
           failure:(void (^)(NSError *))failure;

+ (void)postWithUrl:(NSString *)url
              param:(id)param
        resultClass:(Class)resultClass
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure;

@end

NS_ASSUME_NONNULL_END
