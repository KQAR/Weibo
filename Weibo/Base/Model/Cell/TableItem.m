//
//  TabelItem.m
//  Weibo
//
//  Created by he on 2018/11/7.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "TableItem.h"

@implementation TableItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    TableItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
