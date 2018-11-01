//
//  Emotion.m
//  Weibo
//
//  Created by he on 2018/11/1.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "Emotion.h"

@implementation Emotion
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}
@end
