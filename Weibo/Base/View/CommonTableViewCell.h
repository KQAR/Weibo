//
//  CommonTableViewCell.h
//  Weibo
//
//  Created by he on 2018/11/7.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableItem;

NS_ASSUME_NONNULL_BEGIN

@interface CommonTableViewCell : UITableViewCell

/** cell对应的item数据 */
@property (nonatomic, strong) TableItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows;

@end

NS_ASSUME_NONNULL_END
