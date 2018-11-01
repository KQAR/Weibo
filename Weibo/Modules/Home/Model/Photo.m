//
//  Photo.m
//  Weibo
//
//  Created by he on 2018/10/19.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
