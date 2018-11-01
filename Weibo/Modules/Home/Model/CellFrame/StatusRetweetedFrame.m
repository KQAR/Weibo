//
//  StatusRetweetedFrame.m
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "StatusRetweetedFrame.h"
#import "Status.h"
#import "User.h"
#import "StatusPhotosView.h"

@implementation StatusRetweetedFrame

- (void)setRetweetedStatus:(Status *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1.昵称
    CGFloat nameX = StatusCellInset;
    CGFloat nameY = StatusCellInset * 0.5;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithAttributes:@{NSFontAttributeName:StatusRetweetedNameFont}];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + StatusCellInset * 0.5;
    CGFloat maxW = ScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:StatusRetweetedTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 3.配图相册
    CGFloat h = 0;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + StatusCellInset;
        CGSize photosSize = [StatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + StatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + StatusCellInset;
    }
    
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = ScreenWidth;
//    CGFloat h = CGRectGetMaxY(self.textFrame) + StatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
