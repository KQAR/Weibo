//
//  ComposeViewController.m
//  Weibo
//
//  Created by he on 2018/10/18.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    JRLog(@"发微博");
}

@end
