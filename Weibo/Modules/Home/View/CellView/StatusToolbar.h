//
//  StatusToolBar.h
//  Weibo
//
//  Created by he on 2018/10/31.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  Status;

NS_ASSUME_NONNULL_BEGIN

@interface StatusToolbar : UIImageView
@property (nonatomic, assign) Status *status;
@end

NS_ASSUME_NONNULL_END
