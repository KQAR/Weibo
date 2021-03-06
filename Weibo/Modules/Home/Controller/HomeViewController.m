//
//  HomeViewController.m
//  Weibo
//
//  Created by he on 2018/10/10.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "HomeViewController.h"
#import "JRTitleButton.h"
#import "JRPopMenu.h"
#import "AccountManager.h"
#import "Account.h"
#import "UIImageView+WebCache.h"
#import "LoadMoreFooter.h"
#import "StatusManager.h"
#import "UserManager.h"
#import "StatusFrame.h"
#import "StatusCell.h"

@interface HomeViewController () <JRPopMenuDelegate>
/** 微博数组 **/
@property (nonatomic, strong) NSMutableArray *statusFrames;

@property (nonatomic, weak) UIRefreshControl *refreshControl;
@property (nonatomic, weak) LoadMoreFooter *footer;
@property (nonatomic, weak) JRTitleButton *titleButton;
@end

@implementation HomeViewController

#pragma mark - 初始化

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = RGB(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航栏
    [self setupNavBar];
    
    // 刷新控件
    [self setupRefresh];
    
    // 获取用户信息
    [self setupUserInfo];

}

#pragma mark - 设置导航栏

- (void)setupNavBar
{
    //设置导航栏左右两边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highlightedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(friendSearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highlightedImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(pop)];
    
    //设置导航栏中间的标题按钮
    JRTitleButton *titleButton = [JRTitleButton titleButton];
    //设置尺寸
//    titleButton.width = 100;
    titleButton.height = 35;
    //设置文字和它的颜色、字体
    NSString *name = [AccountManager account].name;
    [titleButton setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = JRNavigationTitleFont;
    //设置图标
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //设置点击时的背景
    [titleButton setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    //监听按钮点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
}

#pragma mark - 设置刷新控件

- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refresh];
    self.refreshControl = refresh;
    
    // 2.监听状态
    [refresh addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    // 3.让刷新控件自动进入刷新状态
    [refresh beginRefreshing];
    // 4.加载数据
    [self refreshControlStateChange:refresh];
    // 5.加载上拉刷新控件
    LoadMoreFooter *footer = [LoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    self.footer = footer; 
}

#pragma mark - 点击tabbar刷新

- (void)refresh:(BOOL)fromSelf
{
    if (self.tabBarItem.badgeValue) {
        // 转圈圈
        [self.refreshControl beginRefreshing];
        
        // 刷新数据
        [self loadNewStatuses:self.refreshControl];
    } else if (fromSelf) { // 没有数字
        // 让表格回到最顶部
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


#pragma mark - 获取用户信息

- (void)setupUserInfo
{
    // 1.封装请求参数
    UserInfoParam *param = [UserInfoParam param];
    param.uid = [AccountManager account].uid;
    
    // 2.加载用户信息 
    [UserManager userInfoWithParam:param success:^(UserInfoResult * _Nonnull result) {
        // 设置用户的昵称为标题
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        
        // 存储账号信息
        Account *account = [AccountManager account];
        account.name = result.name;
        [AccountManager save:account];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"用户信息请求失败-------%@", error);
    }];
    
}

#pragma mark - 加载微博数据

/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (Status *status in statuses) {
        StatusFrame *frame = [[StatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

#pragma mark - 加载微博数据

- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
}

#pragma mark - 加载最新微博数据

- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    // 1.封装请求参数
    HomeStatusesParam *param = [HomeStatusesParam param];
    StatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    Status *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        param.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    // 2.加载微博数据
    [StatusManager homeStatusesWithParam:param success:^(HomeStatusesResult * _Nonnull result) {
        // 获得最新微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        
        // 将新数据插入到旧数据的前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 刷新控件停止刷新
        [refreshControl endRefreshing];
        
        // 提示用户刷出的微博数量
        [self showNewStatusesCount:newFrames.count];
    } failure:^(NSError * _Nonnull error) {
        JRLog(@"请求失败---%@", error);
        // 刷新控件停止刷新
        [refreshControl endRefreshing];
    }];
}

#pragma mark - 加载更多以前的微博数据

- (void)loadMoreStatuses
{
    // 1.封装请求参数、
    HomeStatusesParam *param = [HomeStatusesParam param];
    StatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    Status *lastStatus =  lastStatusFrame.status;
    if (lastStatus) {
        // max_id    false    int64    若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        param.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    
    // 2.加载微博数据
    [StatusManager homeStatusesWithParam:param success:^(HomeStatusesResult * _Nonnull result) {
        // 微博字典数组 ---> 微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        
        // 将新数据插入到旧数据的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    }];
}

#pragma mark - 提示用户刷出的微博数量

- (void)showNewStatusesCount:(NSInteger)count
{
    // 0.清零提醒数字
    [UIApplication sharedApplication].applicationIconBadgeNumber -= self.tabBarItem.badgeValue.intValue;
    self.tabBarItem.badgeValue = nil;
    
    // 1. 创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    
    // 2. 显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%ld条新微博数据", count];
    } else {
        label.text = @"没有最新的微博数据";
    }
    
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.width;
    label.height = 34;
    label.x = 0;
    label.y = 30;
    
    // 5.添加到导航控制器的view
//    [self.navigationController.view addSubview:label];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 6.动画
    CGFloat duration = 1.0;
//    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
//        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        // 延迟delay秒后，在执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
//            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
}

#pragma mark - 导航栏标题点击方法

- (void)titleClick:(UIButton *)titleButton
{
    //箭头向上
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
   
    //弹出菜单
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    
    JRPopMenu *popMenu = [[JRPopMenu alloc] initWithContentView:button];
    popMenu.delegate = self;
    popMenu.dimBackground = YES;
    popMenu.arrowPosition = JRPopMenuArrowPositionCenter;
    [popMenu showInRect:CGRectMake(130, 80, 100, 200)];
}

#pragma mark - 弹出菜单协议

- (void)popMenuDidDismissed:(JRPopMenu *)popMenu
{
    JRTitleButton *titleButton = (JRTitleButton *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

- (void)friendSearch
{
    JRLog(@"friendSearch ----");
}

- (void)pop
{
    JRLog(@"pop -----");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.tableFooterView.hidden = self.statusFrames.count == 0;
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

#pragma mark - tableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVC = [[UIViewController alloc] init];
    newVC.view.backgroundColor = [UIColor purpleColor];
    newVC.title = @"新控制器";
    [self.navigationController pushViewController:newVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count <= 0 || self.footer.isRefreshing)
    {
        NSLog(@"滚动~~~");
        return;
    }
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
        NSLog(@"看全了footer");
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的微博数据
            [self loadMoreStatuses];
        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

@end
