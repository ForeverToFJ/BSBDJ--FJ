//
//  FJTopicPictureView.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/18.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTopicPictureView.h"
#import "FJTopic.h"
#import "UIImageView+WebCache.h"
#import "FJProgressView.h"
#import "FJShowPictureViewController.h"

@interface FJTopicPictureView ()

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  gif图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
/**
 *  查看大图
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/**
 *  进度条控件
 */
@property (weak, nonatomic) IBOutlet FJProgressView *progressView;

@end

@implementation FJTopicPictureView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 让图片能点击
    self.imageView.userInteractionEnabled = YES;
    // 给图片添加监听器
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture {
    FJShowPictureViewController *vc = [[FJShowPictureViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(FJTopic *)topic {
    _topic = topic;
    
    // 显示最新的进度值(上一次的)
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
//        NSLog(@"%zd -- %zd", receivedSize, expectedSize);
        self.progressView.hidden = NO;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if (topic.isBigPicture) {
            // 开启图形上下文
            UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0.0);
            
            // 将下载完的image对象绘制给上下文
            CGFloat width = topic.pictureViewFrame.size.width;
            CGFloat height = width * image.size.height / image.size.width;
            [image drawInRect:CGRectMake(0, 0, width, height)];
            
            // 获取图片
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            
            // 结束图形上下午
            UIGraphicsEndImageContext();
        }        
    }];
    
    // 是否为gif图
    self.gifImageView.hidden = !topic.is_gif;
    
    // 是否为长图
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }

}

@end
