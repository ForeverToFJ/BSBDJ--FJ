//
//  FJRecommendViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/6.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "FJRecommendCategoryCell.h"
#import "FJRecommendCategory.h"
#import "MJExtension.h"
#import "FJRecommendUserCell.h"
#import "FJRecommendUser.h"
#import "MJRefresh.h"

#define FJSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface FJRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 *  右边的TableView
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**
 *  左边的TableView
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**
 *  左边的类别数据
 */
@property (nonatomic, strong) NSArray *categories;
/**
 *  请求参数
 */
@property (nonatomic, strong) NSMutableDictionary *params;
/**
 *  AFN请求管理者
 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation FJRecommendViewController

static NSString * const FJCategoryID = @"category";
static NSString * const FJUserID = @"user";

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // 初始化界面
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
    
    self.userTableView.delegate = self;
    NSLog(@"%@", self);
}

/**
 *  加载左侧的类别数据
 */
- (void)loadCategories {
    
    // 设置指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        FJLog(@"1");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        FJLog(@"%@", responseObject);
        
        // 隐藏指示器
        [SVProgressHUD dismiss];
        // 获取JSON数据
        self.categories = [FJRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FJLog(@"%@", error);
        // 隐藏指示器   显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];

}

/**
 *  初始化TableView
 */
- (void)setupTableView {
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:FJCategoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:FJUserID];
    
    self.categoryTableView.tableFooterView = [UIView new];
    self.userTableView.tableFooterView = [UIView new];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 标题
    self.title = @"推荐关注";
    // 背景色
    self.view.backgroundColor = FJGlobalBG
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh {
    
    //
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

}

#pragma mark - 加载用户数据
- (void)loadMoreUsers {
    
    FJRecommendCategory *category = FJSelectedCategory;
    
    // 请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(++category.current_page);
    self.params = params;
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        FJLog(@"2");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //            NSLog(@"%@", responseObject);
        
        // 获取JSON数据
        NSArray *users = [FJRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 避免多次请求 -> 不是最后一次请求
        if (self.params != params) {
            return;
        }
        
        // 刷新列表
        [self.userTableView reloadData];
        
        // 结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 避免多次请求 -> 不是最后一次请求
        if (self.params != params) {
            return;
        }
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewUsers {
    
    FJRecommendCategory *model = FJSelectedCategory;
    
    // 设置当前页码为1
    model.current_page = 1;
    
    // 请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([FJSelectedCategory ID]);
    params[@"page"] = @(model.current_page);
    self.params = params;
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        FJLog(@"2");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //            NSLog(@"%@", responseObject);
        // 获取JSON数据
        NSArray *users = [FJRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清楚所有旧数据
        [model.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [model.users addObjectsFromArray:users];
        
        // 保存总数
        model.total = [responseObject[@"total"] integerValue];
        
        // 避免多次请求 -> 不是最后一次请求
        if (self.params != params) {
            return;
        }

        // 刷新列表
        [self.userTableView reloadData];
        
        // 结束下拉刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 上拉
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FJLog(@"error:%@", error);
        // 避免多次请求 -> 不是最后一次请求
        if (self.params != params) {
            return;
        }
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

/**
 *  时刻监测footer的状态
 */
- (void)checkFooterState {
    FJRecommendCategory *category = FJSelectedCategory;
    
    // 每次刷新右边数据时,都控制footer显示or隐藏
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    // 结束刷新
    if (category.users.count == category.total) {
        // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }
    else {
        // 等待下次上拉
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    else {
        // 监测footer的状态
        [self checkFooterState];
        return [FJSelectedCategory users].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTableView) {
        FJRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:FJCategoryID];
        
        cell.category = self.categories[indexPath.row];
        return cell;
    }
    else {
        FJRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:FJUserID];
        // 左边选中的类别
        cell.user = [FJSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 结束下拉刷新
    [self.userTableView.mj_header endRefreshing];
    
    // 结束上拉刷新
    [self.userTableView.mj_footer endRefreshing];
    
    FJRecommendCategory *model = self.categories[indexPath.row];
    
    // 停止上次的加载更多
    [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    
    if (model.users.count) {
        // 刷新列表
        [self.userTableView reloadData];
    }
    else {
        // 刷新列表,不要显示上一次的数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器销毁
- (void)dealloc {
    FJLog(@"控制器销毁了~");
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}
@end
