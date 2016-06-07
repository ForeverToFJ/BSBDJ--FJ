//
//  FJTopicVoiceView.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/24.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTopicVoiceView.h"
#import "UIImageView+WebCache.h"
#import "FJTopic.h"
#import "FJShowPictureViewController.h"
#import <AVFoundation/AVFoundation.h>

static NSInteger count = 1;

@interface FJTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcount;
@property (weak, nonatomic) IBOutlet UILabel *voicetime;

/**
 *  音乐播放器
 */
@property (nonatomic, strong) AVPlayer *player;
/**
 *  上一次的url
 */
@property (nonatomic, strong) NSString *lastVoiceURL;
/**
 *  上一次的播放器
 */
@property (nonatomic, strong) AVPlayer *lastPlayer;

@end

@implementation FJTopicVoiceView

- (AVPlayer *)player {
    if (!_player) {
        AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        
        _player = [AVPlayer playerWithPlayerItem:playItem];
    }
    return _player;
}

+ (instancetype)voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;

    // 让图片能点击
    self.imageView.userInteractionEnabled = YES;
    // 给图片添加监听器
//    if (count % 2 == 1) {
        [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVoice)]];
//    }
//    else {
//        [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseVoice)]];
//    }
    
}

- (void)showVoice {
 
    AVPlayer *player = [[AVPlayer alloc] init];
    
    if ([self.lastVoiceURL isEqualToString:self.topic.voiceuri] && count % 2 == 0) {
        NSLog(@"1");
        [self.lastPlayer pause];
    }
    else if ([self.lastVoiceURL isEqualToString:self.topic.voiceuri] && count % 2 == 1) {
        NSLog(@"2");
        [self.lastPlayer play];
    }
    else {
        NSLog(@"3");
//        [self.lastPlayer stop];
        [self.lastPlayer pause];
        self.lastPlayer = nil;
        count = 1;
        
        // 创建播放器
        NSLog(@"%@", self.topic.voiceuri);
        AVPlayerItem *nextPlayer = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        self.lastVoiceURL = self.topic.voiceuri;
        player = [AVPlayer playerWithPlayerItem:nextPlayer];
        self.lastPlayer = player;
        
        // 播放
        [self.lastPlayer play];
    }
    NSLog(@"4");
    count++;
    
//    NSLog(@"%@--%@", self.player, self.lastPlayer);
}

- (void)setTopic:(FJTopic *)topic {
    _topic = topic;
    
    // 设置图片
//    NSLog(@"%@", topic.voiceuri);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    // 时长
    self.voicetime.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
    // 次数
    NSString *playCount;
    if (topic.playcount < 10000) {
        playCount = [NSString stringWithFormat:@"%zd次播放", topic.playcount];
    }
    else {
        playCount = [NSString stringWithFormat:@"%.1f万次播放", topic.playcount / 10000.0];
    }
    self.playcount.text = playCount;
}

@end
