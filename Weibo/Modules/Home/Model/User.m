//
//  User.m
//  Weibo
//
//  Created by he on 2018/10/19.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "User.h"

@implementation User

- (BOOL)isVip
{
    // 是会员
    return self.mbtype > 2;
}


@end
