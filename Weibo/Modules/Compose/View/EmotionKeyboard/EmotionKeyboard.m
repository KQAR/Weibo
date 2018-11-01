//
//  EmotionKeyboard.m
//  Weibo
//
//  Created by he on 2018/11/1.
//  Copyright © 2018年 huashan. All rights reserved.
//

#import "EmotionKeyboard.h"
#import "EmotionListView.h"
#import "EmotionToolbar.h"
#import "MJExtension.h"
#import "Emotion.h"

@interface EmotionKeyboard() <EmotionToolbarDelegate>
/** 表情列表 */
@property (nonatomic, weak) EmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) EmotionToolbar *toollbar;

/** 默认表情 */
@property (nonatomic, strong) NSArray *defaultEmotions;
/** emoji表情 */
@property (nonatomic, strong) NSArray *emojiEmotions;
/** 浪小花表情 */
@property (nonatomic, strong) NSArray *lxhEmotions;
@end

@implementation EmotionKeyboard

- (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultEmotions = [Emotion mj_objectArrayWithFile:plist];
    }
    return _defaultEmotions;
}

- (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiEmotions = [Emotion mj_objectArrayWithFile:plist];
    }
    return _emojiEmotions;
}

- (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhEmotions = [Emotion mj_objectArrayWithFile:plist];
    }
    return _lxhEmotions;
}

+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        // 1.添加表情列表
        EmotionListView *listView = [[EmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        EmotionToolbar *toolbar = [[EmotionToolbar alloc] init];
        toolbar.delegate = self;
        [self addSubview:toolbar];
        self.toollbar = toolbar;
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条的frame
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toollbar.y;
}

#pragma mark - HMEmotionToolbarDelegate

- (void)emotionToolbar:(EmotionToolbar *)toolbar didSelectedButton:(EmotionType)emotionType
{
    switch (emotionType) {
        case EmotionTypeDefault:// 默认
            self.listView.emotions = self.defaultEmotions;
            break;
            
        case EmotionTypeEmoji: // Emoji
            self.listView.emotions = self.emojiEmotions;
            break;
            
        case EmotionTypeLxh: // 浪小花
            self.listView.emotions = self.lxhEmotions;
            break;
            
        default:
            break;
    }
    
    JRLog(@"%d %@", self.listView.emotions.count, [self.listView.emotions firstObject]);
}

@end
