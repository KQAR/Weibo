//
//  UIImage+Extension.m
//  Weibo
//
//  Created by he on 2018/10/11.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizedImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    //stretchableImage创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
