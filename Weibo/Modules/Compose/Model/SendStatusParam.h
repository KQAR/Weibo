//
//  SendStatusParam.h
//  Weibo
//
//  Created by he on 2018/10/23.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendStatusParam : BaseParam

/**    true    string    要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
@property (nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
