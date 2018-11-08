//
//  ProfileViewController.m
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "ProfileViewController.h"
#import "TableGroup.h"
#import "TableItem.h"
#import "ArrowItem.h"
#import "SwitchItem.h"
#import "LabelItem.h"
#import "SettingViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化模型数据
    [self setupGroups];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
}

- (void)setting
{
    SettingViewController *setting = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark -  初始化模型数据

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 1.创建组
    TableGroup *group = [TableGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    ArrowItem *newFriend = [ArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];

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

@end
