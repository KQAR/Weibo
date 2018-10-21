//
//  LoadMoreFooter.m
//  Weibo
//
//  Created by he on 2018/10/21.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "LoadMoreFooter.h"

@interface LoadMoreFooter()
@property (strong, nonatomic) IBOutlet UILabel *tableFooterLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadView;
@end

@implementation LoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LoadMoreFooter" owner:nil options:nil] lastObject];
}

- (void)beginRefreshing
{
    self.tableFooterLabel.text = @"正在拼命加载更多数据...";
    [self.loadView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.tableFooterLabel.text = @"上拉可以加载更多数据";
    [self.loadView stopAnimating];
    self.refreshing = NO;
}

@end
