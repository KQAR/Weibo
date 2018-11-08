//
//  SettingViewController.m
//  Weibo
//
//  Created by he on 2018/11/7.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "SettingViewController.h"
#import "TableGroup.h"
#import "TableItem.h"
#import "ArrowItem.h"
#import "SwitchItem.h"
#import "LabelItem.h"
#import "GeneralSettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    // 初始化模型数据
    [self setupGroups];
    
    [self setupFooter];
}

- (void)setupFooter
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:RGB(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 44;
    
    self.tableView.tableFooterView = logout;
}

#pragma mark -  初始化模型数据

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    TableGroup *group = [TableGroup group];
    [self.groups addObject:group];
    
    group.footer = @"底部";
    
    // 2.设置组的所有行数据
    ArrowItem *newFriend = [ArrowItem itemWithTitle:@"帐号管理"];
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    TableGroup *group = [TableGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    ArrowItem *album = [ArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    ArrowItem *collect = [ArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    ArrowItem *like = [ArrowItem itemWithTitle:@"赞" icon:@"like"];
    
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    // 1.创建组
    TableGroup *group = [TableGroup group];
    [self.groups addObject:group];
    
    group.header = @"头部";
    
    // 2.设置组的所有行数据
    ArrowItem *generalSetting = [ArrowItem itemWithTitle:@"通用设置"];
    generalSetting.destVcClass = [GeneralSettingViewController class];
    
    group.items = @[generalSetting];
}


@end
