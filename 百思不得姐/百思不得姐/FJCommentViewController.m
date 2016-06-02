//
//  FJCommentViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/25.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJCommentViewController.h"
#import "FJTopicCell.h"
#import "FJTopic.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "FJComment.h"
#import "FJCommentHeaderView.h"
#import "FJCommentCell.h"

static NSString * const commentID = @"comment_cell";

@interface FJCommentViewController ()<UITableViewDelegate, UITableViewDataSource>

/**
 *  底部间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  最热评论
 */
@property (nonatomic, strong) NSArray *hotComments;
/**
 *  最新评论
 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/**
 *  保存帖子的top_cmt
 */
@property (nonatomic, strong) FJComment *saved_top_cmt;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger page;
/**
 *  管理者
 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/**
 *  点击的行号
 */
@property (nonatomic, strong) NSIndexPath *selected;

@end

@implementation FJCommentViewController

#pragma mark - 懒加载
//- (NSMutableArray *)latestComments {
//    if (!_latestComments) {
//        _latestComments = [NSMutableArray array];
//    }
//    return _latestComments;
//}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    [self setupBasic];
    
    // headerView
    [self setupHeader];
    
    // 上拉下拉刷新
    [self setupRefresh];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

/**
 *  第一波评论
 */
- (void)loadNewComments {
    
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        FJLog(@"4");
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 没有评论数据
            // 结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        // 最热评论
        self.hotComments = [FJComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [FJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 页码
        self.page = 1;
        
        // 刷新列表
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  更多评论
 */
- (void)loadMoreComments {
    
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(self.page++);
    FJComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        FJLog(@"4");
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 没有评论数据
            // 结束刷新
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        // 最新评论
        NSArray *newlatestComments = [FJComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newlatestComments];
        
        // 刷新列表
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else {
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)setupHeader {
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    // 清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    // 添加cell
    FJTopicCell *cell = [FJTopicCell cell];
    cell.topic = self.topic;
    cell.fj_size = CGSizeMake(FJScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    // header的高度
    header.fj_height = cell.fj_height + 2 *  FJTopicCellMargin;
    self.tableView.tableHeaderView = header;
    
}

- (void)setupBasic {
    
    // 标题
    self.title = @"评论";
    
    // 背景色
    self.view.backgroundColor = FJGlobalBG
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 导航条右边控件
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem fj_itemWithImageName:@"comment_nav_item_share_icon" highImageName:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // cell高度
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FJCommentCell class]) bundle:nil] forCellReuseIdentifier:commentID];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 键盘显示/隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.bottomSapce.constant = FJScreenH - frame.origin.y;
    
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 动画
    [UIView animateWithDuration:duration animations:^{
        // 强制布局
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 恢复top_cmt
    if (self.topic.top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    // 取消所有任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}

/**
 *  返回
 */
- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (FJComment *)commentsInIndexPath:(NSIndexPath *)indexPath {
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hotComments.count) return 2;
    if (self.latestComments) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 隐藏尾部控件
    tableView.mj_footer.hidden = (self.latestComments.count == 0);
    
    if (section == 0) {
        return self.hotComments.count ? self.hotComments.count : self.latestComments.count;
    }
    else {
        return self.latestComments.count;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return self.hotComments.count ? @"最热评论" : @"最新评论";
//    }
//    else {
//        return @"最新评论";
//    }
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    // 创建header
    FJCommentHeaderView *header = [FJCommentHeaderView headerViewWithTableView:tableView];

    if (section == 0) {
        header.title = self.hotComments.count ? @"最热评论" : @"最新评论";
    }
    else {
        header.title =  @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      
    FJCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID];

    cell.comment = [self commentsInIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 隐藏键盘
    [self.view endEditing:YES];
    
    // 隐藏UIMenuController
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }
    else {
        // 被点击的cell
        FJCommentCell *cell = (FJCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        // 成为第一响应者
        [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding, replay, report];
        
        CGRect rect = CGRectMake(0, cell.fj_height * 0.5, cell.fj_width, cell.fj_height);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}

#pragma mark - UIMenuItem
- (void)ding:(UIMenuController *)menu {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@", [self commentsInIndexPath:indexPath].content);
}

- (void)replay:(UIMenuController *)menu {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@", [self commentsInIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menu {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@", [self commentsInIndexPath:indexPath].content);
}

@end
