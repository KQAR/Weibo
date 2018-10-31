//
//  StatusOriginalFrame.h
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

NS_ASSUME_NONNULL_BEGIN

@interface StatusOriginalFrame : NSObject

/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
///** 来源 */
//@property (nonatomic, assign) CGRect sourceFrame;
///** 时间 */
//@property (nonatomic, assign) CGRect timeFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconFrame;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 微博数据 */
@property (nonatomic, strong) Status *status;

@end

NS_ASSUME_NONNULL_END
