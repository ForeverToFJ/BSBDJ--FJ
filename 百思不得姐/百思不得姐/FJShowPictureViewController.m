//
//  FJShowPictureViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/19.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJShowPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "FJTopic.h"
#import "SVProgressHUD.h"
#import "FJProgressView.h"

@interface FJShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet FJProgressView *progressView;

@end

@implementation FJShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建UIImageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 给imageview添加点击事件
    imageView.userInteractionEnabled = YES;
    
    // 给imageview添加监控
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    
    // 图片宽高
    CGFloat pictureW = FJScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
//    NSLog(@"%.f-%.f", pictureW, pictureH);
    if (pictureH > FJScreenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }
    else {
        imageView.fj_size = CGSizeMake(pictureW, pictureH);
        imageView.fj_centerY = FJScreenH * 0.5;
    }
    
    // 马上显示图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片未下载!"];
        return;
    }
    
    // 将图片存入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }
    else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}

@end
