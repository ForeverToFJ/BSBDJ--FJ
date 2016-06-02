//
//  FJfriendTrendsViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/4.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJfriendTrendsViewController.h"
#import "FJRecommendViewController.h"
#import "FJloginRegisterViewController.h"

@implementation FJfriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏内容
    self.navigationItem.title = @"我的关注";
    
    // 添加左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem fj_itemWithImageName:@"friendsRecommentIcon" highImageName:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    FJGlobalBG
}

- (void)friendsClick {
    FJRecommendViewController *vc = [[FJRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginRegister {
    FJloginRegisterViewController *vc = [[FJloginRegisterViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
