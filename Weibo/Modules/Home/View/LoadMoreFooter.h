//
//  LoadMoreFooter.h
//  Weibo
//
//  Created by he on 2018/10/21.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadMoreFooter : UIView

+ (instancetype)footer;

- (void)beginRefreshing;

- (void)endRefreshing;

@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;

@end

NS_ASSUME_NONNULL_END
