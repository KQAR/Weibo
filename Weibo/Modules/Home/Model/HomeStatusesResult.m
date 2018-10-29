//
//  HomeStatusesResult.m
//  Weibo
//
//  Created by he on 2018/10/23.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "HomeStatusesResult.h"
#import "Status.h"

@implementation HomeStatusesResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses" : [Status class]};
}

@end 
