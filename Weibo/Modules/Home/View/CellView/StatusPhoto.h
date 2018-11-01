//
//  StatusPhoto.h
//  Weibo
//
//  Created by he on 2018/11/1.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;

NS_ASSUME_NONNULL_BEGIN

@interface StatusPhoto : UIImageView
@property (nonatomic, strong) Photo *photo;
@end

NS_ASSUME_NONNULL_END
