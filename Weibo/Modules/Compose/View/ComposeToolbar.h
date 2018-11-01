//
//  JRToolbar.h
//  Weibo
//
//  Created by he on 2018/10/22.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ComposeToolbarButtonTypeCamera, // 照相机
    ComposeToolbarButtonTypePicture, // 相册
    ComposeToolbarButtonTypeMention, // 提到@
    ComposeToolbarButtonTypeTrend, // 话题
    ComposeToolbarButtonTypeEmotion // 表情
} ComposeToolbarButtonType;

@class ComposeToolbar;

@protocol ComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(ComposeToolbar *)toolbar didClickedButton:(ComposeToolbarButtonType)buttonType;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ComposeToolbar : UIView

@property (nonatomic, weak) id<ComposeToolbarDelegate> delegate;
/**
 *  设置某个按钮的图片
 *
 *  @param image      图片名
 *  @param buttonType 按钮类型
 */
//- (void)setButtonImage:(NSString *)image buttonType:(HMComposeToolbarButtonType)buttonType;

/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;

@end

NS_ASSUME_NONNULL_END
