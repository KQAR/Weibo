//
//  DiscoverViewController.m
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "DiscoverViewController.h"
#import "JRSearchBar.h"
#import "TableGroup.h"
#import "TableItem.h"
//#import "CommonTableViewCell.h"
#import "ArrowItem.h"
#import "SwitchItem.h"
#import "LabelItem.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第一种做导航栏搜索框（系统自带的UISearchBar）
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    searchBar.frame = CGRectMake(0, 0, 300, 35);
//    searchBar.backgroundImage = [UIImage resizedImage:@"searchbar_textfield_background"];
//    searchBar.searchBarStyle = UISearchBarStyleDefault;
//    self.navigationItem.titleView = searchBar;
    
    //第二种做导航栏搜索框（用UITextField自定义）
    JRSearchBar *searchBar = [JRSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    
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
    
    // 2.设置组的基本数据
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    // 3.设置组的所有行数据
    ArrowItem *hotStatus = [ArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    
    ArrowItem *findPeople = [ArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1.创建组
    TableGroup *group = [TableGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    ArrowItem *gameCenter = [ArrowItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    ArrowItem *near = [ArrowItem itemWithTitle:@"周边" icon:@"near"];
    ArrowItem *app = [ArrowItem itemWithTitle:@"应用" icon:@"app"];
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    TableGroup *group = [TableGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    ArrowItem *video = [ArrowItem itemWithTitle:@"视频" icon:@"video"];
    ArrowItem *music = [ArrowItem itemWithTitle:@"音乐" icon:@"music"];
    ArrowItem *movie = [ArrowItem itemWithTitle:@"电影" icon:@"movie"];
    ArrowItem *cast = [ArrowItem itemWithTitle:@"播客" icon:@"cast"];
    LabelItem *more = [LabelItem itemWithTitle:@"更多" icon:@"more"];
    cast.badgeValue = @"998";
    more.text = @"哈哈哈";
    
    group.items = @[video, music, movie, cast, more];
}

@end
