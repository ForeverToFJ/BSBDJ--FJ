//
//  FJPublishViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/19.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJPublishViewController.h"
#import "FJVerticalButton.h"
#import "POP.h"

@interface FJPublishViewController ()

@end

@implementation FJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 让view不能被点击
    self.view.userInteractionEnabled = NO;
    
    // 中间的6个按钮
    // 按钮图片名
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    // 按钮名
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    for (int i = 0; i < images.count; i++) {
        FJVerticalButton *button = [[FJVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算XY
        CGFloat buttonY = (FJScreenH - 2 * buttonH) * 0.5 + buttonH * (i / 3);
        CGFloat buttonX = 25 + ( (FJScreenW - 50 - 3 * buttonW) / 2 + buttonW ) * (i % 3);
        [self.view addSubview:button];
        
        // 添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, -buttonH, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        anim.springSpeed = 15;
        anim.springBounciness = 15;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat sloganViewCenterY = FJScreenH * 0.2;
    CGFloat sloganViewCenterX = FJScreenW * 0.5;
    [self.view addSubview:sloganView];
    sloganView.fj_centerY = -sloganViewCenterY;
    
    // 添加动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganViewCenterX, -sloganViewCenterY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganViewCenterX, sloganViewCenterY)];
    anim.springSpeed = 15;
    anim.springBounciness = 15;
    anim.beginTime = CACurrentMediaTime() + 0.1 * images.count;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 恢复点击
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancel];
}

- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    // 让view不能被点击
    self.view.userInteractionEnabled = NO;
    
    for (int i = 2; i < self.view.subviews.count; i++) {
        UIView *view = self.view.subviews[i];
        
        // 添加动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = view.fj_height +FJScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(view.fj_centerX, centerY)];
        //        anim.springSpeed = 15;
        //        anim.springBounciness = 15;
        anim.beginTime = CACurrentMediaTime() + 0.1 * (i - 2);
        [view pop_addAnimation:anim forKey:nil];
        
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
                // 执行传进来completionBlock参数
//                if (completionBlock) {
//                    completionBlock();
//                }
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    [self cancelWithCompletionBlock:^{
        switch (button.tag) {
            case 0:
                NSLog(@"发视频");
                break;
            case 1:
                NSLog(@"发图片");
                break;
            case 2:
                NSLog(@"发段子");
                break;
            case 3:
                NSLog(@"发声音");
                break;
            case 4:
                NSLog(@"审帖");
                break;
            case 5:
                NSLog(@"离线下载");
                break;
            default:
                break;
        }
    }];
}

@end
