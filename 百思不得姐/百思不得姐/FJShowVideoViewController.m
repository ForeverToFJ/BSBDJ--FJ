//
//  FJShowVideoViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/24.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJShowVideoViewController.h"
#import "FJTopic.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FJShowVideoViewController ()

/**
 *  视频播放器
 */
@property (nonatomic, strong) MPMoviePlayerController *movie;

@end

@implementation FJShowVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //播放
    [self.movie play];
    
    //添加通知
    [self addNotification];
    
//    self.movie = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.topic.videouri]];
////    self.movie.controlStyle = MPMovieControlStyleFullscreen;
//    self.movie.view.frame = self.view.bounds;
//    self.movie.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
////    self.movie.initialPlaybackTime = -1;
//    [self.view addSubview:self.movie.view];
//    [self.movie play];
    
}

- (void)dealloc {
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
- (NSURL *)getVideoUrl {
    return [NSURL URLWithString:self.topic.videouri];
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
- (NSURL *)getNetworkUrl {
    return [NSURL URLWithString:self.topic.videouri];
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
- (MPMoviePlayerController *)movie {
    if (!_movie) {
        NSURL *url = [self getNetworkUrl];
        _movie=[[MPMoviePlayerController alloc] initWithContentURL:url];
        _movie.view.frame = self.view.bounds;
        _movie.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_movie.view];
    }
    return _movie;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
- (void)addNotification {
//    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
//    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.movie];
//    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
- (void)mediaPlayerPlaybackStateChange:(NSNotification *)notification {
    switch (self.movie.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%zd",self.movie.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
- (void)mediaPlayerPlaybackFinished:(NSNotification *)notification {
    NSLog(@"播放完成.%zd",self.movie.playbackState);
}

- (void)movieFinishedCallback:(NSNotification *)notify {
    FJLogFunc
    MPMoviePlayerController *theMovie = [notify object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    FJLogFunc
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    FJLogFunc
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    FJLogFunc
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
