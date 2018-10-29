//
//  UnreadCountResult.m
//  Weibo
//
//  Created by he on 2018/10/29.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "UnreadCountResult.h"

@implementation UnreadCountResult

- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}

@end
