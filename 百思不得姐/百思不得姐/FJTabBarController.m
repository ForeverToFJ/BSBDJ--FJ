//
//  FJTabBarController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/4.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTabBarController.h"
#import "FJEssenceViewController.h"
#import "FJNewViewController.h"
#import "FJfriendTrendsViewController.h"
#import "FJMeViewController.h"
#import "FJTabBar.h"
#import "FJNavigationController.h"

@implementation FJTabBarController

/**
 *  第一次使用调用一次
 */
+ (void)initialize {
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 *  添加子控制器
 *
 *  @param class   控制器
 *  @param title                标题
 *  @param name              图片名字
 */
- (void)addChildController:(UIViewController *)viewController withTitle:(NSString *)title withName:(NSString *)name {
    
    viewController.tabBarItem.title = title;
    
    viewController.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabBar_%@_icon", name]];
   viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabBar_%@_click_icon", name]];
    
    // 添加导航控制器
    FJNavigationController *nav = [[FJNavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:nav];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self addChildController:[[FJEssenceViewController alloc] init] withTitle:@"精华" withName:@"essence"];

    [self addChildController:[[FJNewViewController alloc] init] withTitle:@"新帖" withName:@"new"];

    [self addChildController:[[FJfriendTrendsViewController alloc] init] withTitle:@"关注" withName:@"friendTrends"];

    [self addChildController:[[FJMeViewController alloc] initWithStyle:UITableViewStyleGrouped] withTitle:@"我" withName:@"me"];
    
    // 更换tabBar
    
    [self setValue:[[FJTabBar alloc] init] forKey:@"tabBar"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

@end
