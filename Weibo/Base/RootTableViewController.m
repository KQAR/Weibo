//
//  RootTableViewController.m
//  Weibo
//
//  Created by he on 2018/11/7.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "RootTableViewController.h"
#import "TableGroup.h"
#import "TableItem.h"
#import "CommonTableViewCell.h"
#import "ArrowItem.h"
#import "SwitchItem.h"
#import "LabelItem.h"

@interface RootTableViewController ()
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation RootTableViewController

/**
 用一个模型来描述每组的信息：组头、组尾、这组的所有行模型
 用一个模型来描述每行的信息：图标、标题、子标题、右边的样式（箭头、文字、数字、开关、打钩）
 */

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

/** 屏蔽tableView的样式 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView属性
    self.tableView.backgroundColor = RGB(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.sectionHeaderHeight = 0;
//    self.tableView.sectionFooterHeight = StatusCellMargin;
    
    // 调整cell在tableview中的位置（高度）
//    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TableGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCell *cell = [CommonTableViewCell cellWithTableView:tableView];
    TableGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TableGroup *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    TableGroup *group = self.groups[section];
    return group.footer;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    TableGroup *group = self.groups[indexPath.section];
    TableItem *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
}

@end
