//
//  Status.h
//  Weibo
//
//  Created by he on 2018/10/19.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

NS_ASSUME_NONNULL_BEGIN

@interface Status : NSObject

/** string 微博创建时间 **/
@property (nonatomic, copy) NSString *created_at;

/** string 字符串型的微博ID **/
@property (nonatomic, copy) NSString *idstr;

/** string 微博信息内容 **/
@property (nonatomic, copy) NSString *text;

/** string 微博来源 **/
@property (nonatomic, copy) NSString *source;

/** object 微博作者的用户信息字段 **/
@property (nonatomic, strong) User *user;

/** object 被转发的原微博信息字段，当该微博为转发微博时返回 详细 **/
@property (nonatomic, strong) Status *retweeted_status;

/** int    转发数 **/
@property (nonatomic, assign) int reposts_count;

/** int    评论数 **/
@property (nonatomic, assign) int comments_count;

/** int    表态数 **/
@property (nonatomic, assign) int attitudes_count;

/** object    微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。 **/
@property (nonatomic, strong) NSArray *pic_urls;

//pic_ids

@end

NS_ASSUME_NONNULL_END
