//
//  HomeStatusesResult.h
//  Weibo
//
//  Created by he on 2018/10/23.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeStatusesResult : NSObject

/** 微博数组（装着Status模型） */
@property (nonatomic, strong) NSArray *statuses;

/** 近期的微博总数 */
@property (nonatomic, assign) int total_number;

@end

NS_ASSUME_NONNULL_END
