//
//  JRTextView.m
//  Weibo
//
//  Created by he on 2018/10/22.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "JRTextView.h"

@interface JRTextView()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation JRTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 添加一个占位文字label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        // 设置默认的占位文字颜色
        self.placeholderColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 监听内部文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

#pragma mark — 移除通知

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark — 监听文字改变（隐藏占位文字）

- (void)textDidChange
{
//    if (self.text.length == 0) {
//        self.placeholderLabel.hidden = NO;
//    } else {
//        self.placeholderLabel.hidden = YES;
//    }
    self.placeholderLabel.hidden = (self.text.length != 0);
}

#pragma mark — 公共方法

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    // 重新计算子控件的frame
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    // 重新计算子控件的frame
    [self setNeedsLayout];
}

// 解决由代码输入的文字无法发通知隐藏占位文字的问题
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 8;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
    CGSize placeholderSize = [self.placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:maxSize];
    self.placeholderLabel.height = placeholderSize.height;
}

@end
