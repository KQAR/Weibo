//
//  GeneralSettingViewController.m
//  Weibo
//
//  Created by he on 2018/11/8.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "GeneralSettingViewController.h"
#import "TableGroup.h"
#import "TableItem.h"
#import "ArrowItem.h"
#import "SwitchItem.h"
#import "LabelItem.h"

@interface GeneralSettingViewController ()

@end

@implementation GeneralSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化模型数据
    [self setupGroups];
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
    
    // 2.设置组的所有行数据
    __block LabelItem *readMode = [LabelItem itemWithTitle:@"阅读模式"];
    readMode.text = @"有图模式";
    
    __weak typeof(readMode) weakReadMode = readMode;
    readMode.operation = ^{
        weakReadMode.text = @"无图模式";
    };
    
    group.items = @[readMode];
}

- (void)setupGroup1
{
    
}

- (void)setupGroup2
{
    
}


@end
