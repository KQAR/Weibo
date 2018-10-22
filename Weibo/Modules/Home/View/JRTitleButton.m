//
//  JRTitleButton.m
//  Weibo
//
//  Created by he on 2018/10/11.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "JRTitleButton.h"

@implementation JRTitleButton

+ (instancetype)titleButton
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置高亮是不调整内部图片为灰色
        self.adjustsImageWhenHighlighted = NO;
        //设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置文字右对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

/**
 设置内部图标的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageH = self.height;
    CGFloat imageW = imageH;
    CGFloat imageX = self.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 设置内部文字的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleH = self.height;
    CGFloat titleW = self.width - self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 1.计算文字的尺寸
//    CGSize titleSize = [title sizeWithFont:self.titleLabel.font]; //  Deprecated...
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    
    // 2.计算按钮的宽度
    self.width = titleSize.width + self.height + 10;
}

@end
