//
//  StatusCell.h
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;

NS_ASSUME_NONNULL_BEGIN

@interface StatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) StatusFrame *statusFrame;

@end

NS_ASSUME_NONNULL_END
