//
//  FJTabBar.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/4.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTabBar.h"
#import "FJPublishViewController.h"

@interface FJTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation FJTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        // 添加按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        publishButton.fj_size = publishButton.currentBackgroundImage.size;
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick {
    FJPublishViewController *vc = [[FJPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat width = self.fj_width;
    CGFloat height = self.fj_height;
    
    // 设置Button的frame
//    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
//    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
//    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) {
            continue;
        }
        //                        or
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            continue;
//        }
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            // 监听按钮点击
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    added = YES;
}

- (void)buttonClick {
    // 发通知
    [[NSNotificationCenter defaultCenter] postNotificationName:FJTabBarDidSelectNotification object:nil userInfo:nil];
}

@end
