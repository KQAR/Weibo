//
//  StatusOriginalFrame.m
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "StatusOriginalFrame.h"
#import "Status.h"
#import "User.h"
#import "StatusPhotosView.h"

@implementation StatusOriginalFrame

- (void)setStatus:(Status *)status
{
    _status = status;
    
    // 1.头像
    CGFloat iconX = StatusCellInset;
    CGFloat iconY = StatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + StatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName:StatusOrginalNameFont}];

    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 3.会员图标
    if (status.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + StatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
//    // 4.时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + StatusCellInset * 0.5;
//    CGSize timeSize = [status.created_at sizeWithFont:StatusOrginalTimeFont];
////    CGFloat timeY = CGRectGetMaxY(self.iconFrame) - timeSize.height;
//    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
//
//    // 5.来源
//    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + StatusCellInset;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [status.source sizeWithFont:StatusOrginalSourceFont];
//    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 6.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + StatusCellInset;
    CGFloat maxW = ScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:StatusOrginalTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 7.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + StatusCellInset;
        CGSize photosSize = [StatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + StatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + StatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = ScreenWidth;
//    CGFloat h = CGRectGetMaxY(self.textFrame) + StatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
