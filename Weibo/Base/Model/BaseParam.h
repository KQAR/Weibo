//
//  BaseParam.h
//  Weibo
//
//  Created by he on 2018/10/29.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseParam : NSObject

/**    false    string    采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end

NS_ASSUME_NONNULL_END
