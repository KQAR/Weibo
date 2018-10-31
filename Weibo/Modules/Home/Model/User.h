//
//  User.h
//  Weibo
//
//  Created by he on 2018/10/19.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

/** string 友好显示名称 **/
@property (nonatomic, copy) NSString *name;

/** string 用户头像地址（中图），50×50像素 **/
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter = isVip, readonly) BOOL vip;

@end

NS_ASSUME_NONNULL_END
