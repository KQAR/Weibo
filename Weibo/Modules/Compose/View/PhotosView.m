//
//  PhotosView.m
//  Weibo
//
//  Created by he on 2018/10/22.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "PhotosView.h"

@implementation PhotosView

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    // 图片按照原来的宽高比（图片不拉伸变形）
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    // 按照正方形（多余剪切）
    imageView.clipsToBounds = YES;
    
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    // 一行的最大列数
    NSUInteger maxColsPerRow = 3;
    
    // 每个图片之间的间距
    CGFloat margin = 5;
    
    // 每个图片的宽高
    CGFloat imageViewW = (self.width - (maxColsPerRow - 1) * margin) / maxColsPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i<count; i++) {
        // 行号
        NSUInteger row = i / maxColsPerRow;
        // 列号
        NSUInteger col = i % maxColsPerRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.y = row * (imageViewH + margin);
        imageView.x = col * (imageViewW + margin);
    }
}

- (NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}

@end
