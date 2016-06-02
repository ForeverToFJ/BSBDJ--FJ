//
//  FJRecommendTagsVCTableViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/9.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJRecommendTagsVCTableViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "FJRecommendTag.h"
#import "FJRecommendTagCell.h"

@interface FJRecommendTagsVCTableViewController ()

/**
 *  标签数组
 */
@property (nonatomic, strong) NSArray *tags;

@end

static NSString * const FJTagsID = @"tag";

@implementation FJRecommendTagsVCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    [self setupTableView];
    
    // 加载数据
    [self loadTags];
    
}

/**
 *  初始化界面
 */
- (void)setupTableView {
    // 设置标题
    self.title = @"推荐标签";
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:FJTagsID];
    
    // 设置cell行高
    self.tableView.rowHeight = 70;
    
    // 取消系统自带的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 背景色
    self.tableView.backgroundColor = FJGlobalBG;
}

/**
 *  加载数据
 */
- (void)loadTags {
    // 设置指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        FJLog(@"3");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags = [FJRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新列表
        [self.tableView reloadData];
        
        // 关闭指示器
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏指示器   显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FJRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:FJTagsID];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end
