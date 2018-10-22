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
#import "AccountTool.h"
#import "Account.h"
#import "UIImageView+WebCache.h"
#import "Status.h"
#import "User.h"
#import "LoadMoreFooter.h"

@interface HomeViewController () <JRPopMenuDelegate>
/** 微博数组 **/
@property (nonatomic, strong) NSMutableArray *statuses;

@property (nonatomic, weak) LoadMoreFooter *footer;
@property (nonatomic, weak) JRTitleButton *titleButton;
@end

@implementation HomeViewController

#pragma mark - 初始化

- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    NSString *name = [AccountTool account].name;
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

#pragma mark - 获取用户信息

- (void)setupUserInfo
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"uid"] = [AccountTool account] .uid;
    
    // 2.发送GET请求
    [HttpTool get:URL_User params:params success:^(id  _Nonnull responseObject) {
        // 字典转模型
        User *user = [User mj_objectWithKeyValues:responseObject];
        
        // 设置用户的昵称为标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储账号信息
        Account *account = [AccountTool account];
        account.name = user.name;
        [AccountTool save:account];
    } failure:^(NSError * _Nonnull error) {
        
    }];
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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    Status *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        params[@"since_id"] = firstStatus.idstr;
    }
    params[@"count"] = @10;
    
    // 2.发送GET请求
    [HttpTool get:URL_NewStatus params:params success:^(id  _Nonnull responseObject) {
        // 微博字典数组
        NSArray *statusDictArray = responseObject[@"statuses"];
        
        // 微博字典数组 ---> 微博模型数组
        NSArray *newStatuses = [Status mj_objectArrayWithKeyValuesArray:statusDictArray];
        
        // 将新数据插入到旧数据的前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 刷新控件停止刷新
        [refreshControl endRefreshing];
        
        // 提示用户刷出的微博数量
        [self showNewStatusesCount:newStatuses.count];
    } failure:^(NSError * _Nonnull error) {
        JRLog(@"请求失败---%@", error);
        // 刷新控件停止刷新
        [refreshControl endRefreshing];
    }];
}

#pragma mark - 加载更多以前的微博数据

- (void)loadMoreStatuses
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    Status *lastStatus =  [self.statuses lastObject];
    if (lastStatus) {
        // max_id    false    int64    若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        params[@"max_id"] = @([lastStatus.idstr longLongValue] - 1);
    }
    
    // 2.发送GET请求
    [HttpTool get:URL_NewStatus params:params success:^(id  _Nonnull responseObject) {
        // 微博字典数组
        NSArray *statusDictArray = responseObject[@"statuses"];
        // 微博字典数组 ---> 微博模型数组
        NSArray *newStatuses = [Status mj_objectArrayWithKeyValuesArray:statusDictArray];
        
        // 将新数据插入到旧数据的最后面
        [self.statuses addObjectsFromArray:newStatuses];
        
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
    tableView.tableFooterView.hidden = self.statuses.count == 0;
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    // 取出这行对应的微博数据
    Status *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    // 取出用户字典数据
    User *user = status.user;
    cell.detailTextLabel.text = user.name;
    // 下载头像
    NSString *imageUrlStr = user.profile_image_url;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
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
    if (self.statuses.count <= 0 || self.footer.isRefreshing)
    {
        NSLog(@"跳出盘帝国");
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

@end
