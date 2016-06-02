//
//  FJTopicVideo.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/24.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTopicVideoView.h"
#import "FJTopic.h"
#import "UIImageView+WebCache.h"
#import "FJShowVideoViewController.h"

@interface FJTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;

@end

@implementation FJTopicVideoView

+ (instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 让图片能点击
    self.imageView.userInteractionEnabled = YES;
    // 给图片添加监听器
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideo)]];
}

- (void)showVideo {

    FJShowVideoViewController *vc = [[FJShowVideoViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(FJTopic *)topic {
    _topic = topic;
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    // 时长
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.videotime / 60, topic.videotime % 60];
    // 次数
    NSString *playCount;
    if (topic.playcount < 10000) {
        playCount = [NSString stringWithFormat:@"%zd次播放", topic.playcount];
    }
    else {
        playCount = [NSString stringWithFormat:@"%.1f万次播放", topic.playcount / 10000.0];
    }
    self.playCount.text = playCount;
}


@end
