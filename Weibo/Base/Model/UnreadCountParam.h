//
//  UnreadCountParam.h
//  Weibo
//
//  Created by he on 2018/10/29.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "BaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface UnreadCountParam : BaseParam

/** false    int64    需要查询的用户ID。*/
@property (nonatomic, copy) NSString *uid;

@end

NS_ASSUME_NONNULL_END
