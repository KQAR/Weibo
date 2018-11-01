//
//  StatusRetweetedFrame.h
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

NS_ASSUME_NONNULL_BEGIN

@interface StatusRetweetedFrame : NSObject

/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 配图相册  */
@property (nonatomic, assign) CGRect photosFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 转发微博的数据 */
@property (nonatomic, strong) Status *retweetedStatus;

@end

NS_ASSUME_NONNULL_END
