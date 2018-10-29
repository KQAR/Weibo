//
//  UnreadCountResult.h
//  Weibo
//
//  Created by he on 2018/10/29.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnreadCountResult : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;

/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;

/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;

/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;

/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_status;

/**
 *  消息未读数
 */
- (int)messageCount;

/**
 *  所有未读数
 */
- (int)totalCount;

@end

NS_ASSUME_NONNULL_END
