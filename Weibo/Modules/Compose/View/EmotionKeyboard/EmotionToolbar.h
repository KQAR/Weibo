//
//  EmotionToolbar.h
//  Weibo
//
//  Created by he on 2018/11/1.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionToolbar;

typedef enum {
    EmotionTypeRecent, // 最近
    EmotionTypeDefault, // 默认
    EmotionTypeEmoji, // Emoji
    EmotionTypeLxh // 浪小花
} EmotionType;

@protocol EmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(EmotionToolbar *)toolbar didSelectedButton:(EmotionType)emotionType;
@end

NS_ASSUME_NONNULL_BEGIN

@interface EmotionToolbar : UIView
@property (nonatomic, weak) id<EmotionToolbarDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
