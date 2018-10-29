//
//  BaseParam.m
//  Weibo
//
//  Created by he on 2018/10/29.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "BaseParam.h"
#import "AccountManager.h"
#import "Account.h"

@implementation BaseParam

- (id)init
{
    if (self = [super init]) {
        self.access_token = [AccountManager account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

@end
