//
//  StatusPhotosView.h
//  Weibo
//
//  Created by he on 2018/11/1.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatusPhotosView : UIView
/**
 *  图片数据（里面都是Photo模型）
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(NSUInteger)photosCount;

@end

NS_ASSUME_NONNULL_END
