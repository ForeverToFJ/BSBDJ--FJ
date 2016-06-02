//
//  FJPushGuideView.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/12.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJPushGuideView.h"

@implementation FJPushGuideView

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show {
    // 当前版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        FJPushGuideView *guideView = [FJPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

@end
