//
//  UserInfoParam.h
//  Weibo
//
//  Created by he on 2018/10/23.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoParam : BaseParam

/** false    int64    需要查询的用户ID。*/
@property (nonatomic, copy) NSString  *uid;

@end

NS_ASSUME_NONNULL_END
