//
//  FJShowVideoVC.m
//  百思不得姐
//
//  Created by  高帆 on 16/6/7.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJShowVideoVC.h"
#import "FJTopic.h"
#import "VideoPlayView.h"
#import "FullViewController.h"

@interface FJShowVideoVC ()

/**
 *  播放器
 */
@property (nonatomic, weak) VideoPlayView *playView;

@end

@implementation FJShowVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupVideoPlayView];
    
    [self.playView setUrlString:self.topic.videouri];
    
}

- (void)setupVideoPlayView {
    VideoPlayView *playView = [VideoPlayView videoPlayView];
    CGFloat playViewW = FJScreenW;
    CGFloat playViewH = playViewW * 9 / 16;
    CGFloat playViewY = (FJScreenH - 64) - playViewH * 0.5;
    playView.frame = CGRectMake(0, 64, playViewW, playViewH);
    [self.view addSubview:playView];
    self.playView = playView;
    playView.contrainerViewController = self;
}

@end
