//
//  StatusPhotosView.m
//  Weibo
//
//  Created by he on 2018/11/1.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "StatusPhotosView.h"
#import "StatusPhoto.h"
#import "Photo.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define StatusPhotosMaxCount 9
#define StatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define StatusPhotoW ((ScreenWidth - 2 * StatusCellInset - 2 * StatusPhotoMargin) / 3)
#define StatusPhotoH StatusPhotoW
#define StatusPhotoMargin 5

@interface StatusPhotosView()
@end

@implementation StatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 预先创建9个图片控件
        for (int i = 0; i<StatusPhotosMaxCount; i++) {
            StatusPhoto *photoView = [[StatusPhoto alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    NSUInteger count = self.pic_urls.count;
    for (int i = 0; i<count; i++) {
        Photo *pic = self.pic_urls[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 3.显示浏览器
    [browser show];
}

//- (void)tapCover:(UITapGestureRecognizer *)recognizer
//{
//    [UIView animateWithDuration:2.0 animations:^{
//        recognizer.view.backgroundColor = [UIColor clearColor];
//        self.imageView.frame = self.lastFrame;
//    } completion:^(BOOL finished) {
//        [recognizer.view removeFromSuperview];
//        self.imageView = nil;
//    }];
//}


- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i<StatusPhotosMaxCount; i++) {
        StatusPhoto *photoView = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示图片
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.pic_urls.count;
    NSUInteger maxCols = StatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        StatusPhoto *photoView = self.subviews[i];
        photoView.width = StatusPhotoW;
        photoView.height = StatusPhotoH;
        photoView.x = (i % maxCols) * (StatusPhotoW + StatusPhotoMargin);
        photoView.y = (i / maxCols) * (StatusPhotoH + StatusPhotoMargin);
    }
}


+ (CGSize)sizeWithPhotosCount:(NSUInteger)photosCount
{
    // 一行最多几列
    NSUInteger maxCols = StatusPhotosMaxCols(photosCount);
    
    // 总列数
    NSUInteger totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    // 知道总个数
    // 知道每一页最多显示多少个
    // 能算出一共能显示多少页
    NSUInteger totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * StatusPhotoW + (totalCols - 1) * StatusPhotoMargin;
    CGFloat photosH = totalRows * StatusPhotoH + (totalRows - 1) * StatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
//        int totalRows = 0;
//        if (status.pic_urls.count % maxCols == 0) {
//            totalRows = status.pic_urls.count / maxCols;
//        } else {
//            totalRows = status.pic_urls.count / maxCols + 1;
//        }

@end
