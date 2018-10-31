//
//  StatusDetailFrame.h
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status, StatusOriginalFrame, StatusRetweetedFrame;

NS_ASSUME_NONNULL_BEGIN

@interface StatusDetailFrame : NSObject

@property (nonatomic, strong) StatusOriginalFrame *originalFrame;
@property (nonatomic, strong) StatusRetweetedFrame *retweetedFrame;

/** 微博数据 */
@property (nonatomic, strong) Status *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;

@end

NS_ASSUME_NONNULL_END
