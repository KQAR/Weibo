//
//  StatusDetailFrame.m
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "StatusDetailFrame.h"
#import "Status.h"
#import "StatusOriginalFrame.h"
#import "StatusRetweetedFrame.h"


@implementation StatusDetailFrame

- (void)setStatus:(Status *)status
{
    _status = status;
    
    // 1.计算原创微博的frame
    StatusOriginalFrame *originalFrame = [[StatusOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    // 2.计算转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        StatusRetweetedFrame *retweetedFrame = [[StatusRetweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        
        // 计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.retweetedFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    // 自己的frame
    CGFloat x = 0;
    CGFloat y = StatusCellMargin;
    CGFloat w = ScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
}

@end
