//
//  Status.m
//  Weibo
//
//  Created by he on 2018/10/19.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "Status.h"
#import "Photo.h"

@implementation Status

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_ids" : [Photo class]};
}

@end
