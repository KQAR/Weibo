//
//  TabelGroup.h
//  Weibo
//
//  Created by he on 2018/11/7.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableGroup : NSObject

/** 组头 */
@property (nonatomic, copy) NSString *header;

/** 组尾 */
@property (nonatomic, copy) NSString *footer;

/** 这组的所有行模型(数组中存放的都是HMCommonItem模型) */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;

@end

NS_ASSUME_NONNULL_END
