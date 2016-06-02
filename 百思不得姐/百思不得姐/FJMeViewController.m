//
//  FJMeViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/4.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJMeViewController.h"
#import "FJMeCell.h"
#import "FJMeFooterView.h"
#import "FJSettingViewController.h"

@interface FJMeViewController ()

@end

@implementation FJMeViewController

static NSString *FJMeID = @"me_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
}

- (void)setupNav {
    // 设置导航栏内容
    self.navigationItem.title = @"我的";
    
    // 添加右边的按钮
    self.navigationItem.rightBarButtonItems = @[
                                                [UIBarButtonItem fj_itemWithImageName:@"mine-setting-icon" highImageName:@"mine-setting-icon-click" target:self action:@selector(settingClick)],
                                                [UIBarButtonItem fj_itemWithImageName:@"mine-moon-icon" highImageName:@"mine-moon-icon-click" target:self action:@selector(moonClick)]
                                                ];
}

- (void)setupTableView {
    // 设置背景色
    FJGlobalBG
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FJMeID];
    
    // 分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[FJMeCell class] forCellReuseIdentifier:FJMeID];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = FJTopicCellMargin;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(FJTopicCellMargin - 35, 0, 0, 0);
    
    // 设置footerView
    self.tableView.tableFooterView = [[FJMeFooterView alloc] init];
}

- (void)settingClick {
    FJSettingViewController *vc = [[FJSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)moonClick {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = FJRGBColor(200, 100, 50);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableViewDataSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FJMeID];

    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
