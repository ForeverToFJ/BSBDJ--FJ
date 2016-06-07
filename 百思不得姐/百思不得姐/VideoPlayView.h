//
//  VideoPlayView.h
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/12/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayView : UIView
/** 快速创建 */
+ (instancetype)videoPlayView;

/** 需要播放的视频资源 */
@property (nonatomic,copy) NSString *urlString;

/* 包含在哪一个控制器中 */
@property (nonatomic, weak) UIViewController *contrainerViewController;

@end
