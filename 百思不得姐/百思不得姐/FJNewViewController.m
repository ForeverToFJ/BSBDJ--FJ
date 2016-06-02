//
//  FJNewViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/4.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJNewViewController.h"

@implementation FJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 添加左边的按钮    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem fj_itemWithImageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    FJGlobalBG
}

- (void)tagClick {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = FJRGBColor(200, 100, 50);
    [self.navigationController pushViewController:vc animated:YES];
}
@end
