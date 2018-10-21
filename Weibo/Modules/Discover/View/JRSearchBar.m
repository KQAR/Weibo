//
//  JRSearchBar.m
//  Weibo
//
//  Created by he on 2018/10/11.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "JRSearchBar.h"

@implementation JRSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#warning -- 宽高不写死，由外面决定
        //    searchBar.width = 300;
        //    searchBar.height = 35;
        
        //设置背景
        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
        
        //设置内容垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //设置左边显示一个放大镜
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        //    leftView.size = leftView.image.size;
        leftView.width = leftView.image.size.width + 10;
        leftView.height = leftView.image.size.height;
        
        //设置leftView的内容居中
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        
        //设置左边的view永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //设置显示清除按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
