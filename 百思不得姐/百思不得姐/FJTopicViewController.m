//
//  FJTopicViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/17.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTopicViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "FJTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "FJTopicCell.h"
#import "FJCommentViewController.h"
#import "FJNewViewController.h"

@interface FJTopicViewController ()

/**
 *  帖子数据
 */
@property (nonatomic, strong) NSMutableArray *topics;
/**
 *  页码
 */
@property (nonatomic, assign) NSInteger page;
/**
 *  上一页的最大时间
 */
@property (nonatomic, strong) NSString *maxtime;
/**
 *  最后一次的最大时间
 */
@property (nonatomic, strong) NSString *lastMaxtime;
/**
 *  上一次的请求
 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation FJTopicViewController

#pragma mark - 懒加载
- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

#pragma mark - a参数
- (NSString *)a {
    return [self.parentViewController isKindOfClass:[FJNewViewController class]] ? @"newlist" : @"list";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString *FJTopicCellID = @"topic";
/**
 *  初始化表格
 */
- (void)setupTableView {
    
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.fj_height;
    CGFloat top = FJTitlesViewH + FJTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 背景色
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJTopicCell class]) bundle:nil] forCellReuseIdentifier:FJTopicCellID];
    
    // 监听tabbar的点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:FJTabBarDidSelectNotification object:nil];
}

- (void)tabBarSelect {
    if (self.tabBarController.selectedViewController == self.navigationController && self.view.isShowingOnKeyWindow) {
            [self.tableView.mj_header beginRefreshing];
    }
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh {
    // 下拉
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

/**
 *  加载新数据
 */
- (void)loadNewTopics {
    
    // 结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    // 设置指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        FJLog(@"4");
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if (self.params != params) {
            return;
        }
        
//        NSLog(@"%@", responseObject);
        // 生成plist文件
//        [responseObject writeToFile:@"/Users/GaoFan/Desktop/百思不得姐/Word.plist" atomically:YES];
        
        // 存储maxtime
        self.maxtime = self.lastMaxtime;
        self.lastMaxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [FJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新列表
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 关闭指示器
        [SVProgressHUD dismiss];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) {
            return;
        }
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 隐藏指示器   显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

/**
 *  加载更多数据
 */
- (void)loadMoreTopics {
    
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    NSLog(@"1.%@ - %@", self.maxtime, self.lastMaxtime);
    if (![self.maxtime isEqualToString:self.lastMaxtime])  {
        
        // page自加
        self.page++;
        
        // 请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = self.a;
        params[@"c"] = @"data";
        params[@"type"] = @(self.type);
        params[@"page"] = @(self.page);
        params[@"maxtime"] = self.lastMaxtime;
        self.params = params;
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            FJLog(@"5");
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            
            if (self.params != params) {
                return;
            }
            
            FJLog(@"%@", responseObject);
            
            // 存储maxtime
            self.maxtime = self.lastMaxtime;
            self.lastMaxtime = responseObject[@"info"][@"maxtime"];
            
            NSArray *newTopics = [FJTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.topics addObjectsFromArray:newTopics];
            
            // 刷新列表
            [self.tableView reloadData];
            
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (self.params != params) {
                return;
            }
            
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
            // 显示失败信息
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
            
            // 恢复页码
            self.page--;
        }];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:FJTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 取出帖子模型
    FJTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FJCommentViewController *vc = [[FJCommentViewController alloc] init];
    vc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
