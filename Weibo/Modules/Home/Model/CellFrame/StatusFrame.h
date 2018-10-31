//
//  StatusFrame.h
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status, StatusDetailFrame;

NS_ASSUME_NONNULL_BEGIN

@interface StatusFrame : NSObject

/** 子控件的frame数据 */
@property (nonatomic, assign) CGRect toolbarFrame;
@property (nonatomic, strong) StatusDetailFrame *detailFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 微博数据 */
@property (nonatomic, strong) Status *status;

@end

NS_ASSUME_NONNULL_END
