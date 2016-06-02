//
//  FJEssenceViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/5.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJEssenceViewController.h"
#import "FJRecommendTagsVCTableViewController.h"
#import "FJTopicViewController.h"
#import "FJTopWindow.h"

@interface FJEssenceViewController ()<UIScrollViewDelegate>

/**
 *  标签栏底部指示器
 */
@property (nonatomic, weak) UIView *indicatorView;
/**
 *  当前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedButton;
/**
 *  标签栏
 */
@property (nonatomic, weak) UIView *titlesView;
/**
 *  内容
 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation FJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建导航条
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVC];
    
    // 创建标题栏
    [self setupTitleView];
    
    // 创建底部的scrollView
    [self setupContentView];
    
    // 创建顶部window,使其点击回到顶部
    [FJTopWindow show];

}

/**
 *  创建导航条
 */
- (void)setupNav {
    // 设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 添加左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem fj_itemWithImageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    FJGlobalBG
}

/**
 *  创建标题栏
 */
- (void)setupTitleView {
    
    // 标签栏
    UIView *titlesView = [[UIView alloc] init];
//    titlesView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
//    titlesView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.fj_width = self.view.fj_width;
    titlesView.fj_height = FJTitlesViewH;
    titlesView.fj_y = FJTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.fj_height = 2;
    indicatorView.fj_y = titlesView.fj_height - indicatorView.fj_height;
    // tag
    indicatorView.tag = -1;
    self.indicatorView = indicatorView;
    
    // 内部子标签
//    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat height = titlesView.fj_height;
    CGFloat width = titlesView.fj_width / self.childViewControllers.count;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.fj_height = height;
        button.fj_width = width;
        button.fj_x = i * width;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        
        button.tag = i;
        
        // 强制布局
//        [button layoutIfNeeded];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认选中第一个
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.fj_width = button.titleLabel.fj_width;
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorView.fj_centerX = button.fj_centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

/**
 *  创建底部的scrollView
 */
- (void)setupContentView {
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
//    contentView.backgroundColor = [UIColor redColor];
    contentView.frame = self.view.bounds;
    // 成为代理
    contentView.delegate = self;
    // 分页
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.fj_width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 *  初始化子控制器
 */
- (void)setupChildVC {
    // 全部
    FJTopicViewController *all = [[FJTopicViewController alloc] init];
    all.title = @"全部";
    all.type = FJTopicTypeAll;
    [self addChildViewController:all];
    
    // 视频
    FJTopicViewController *video = [[FJTopicViewController alloc] init];
    video.title = @"视频";
    video.type = FJTopicTypeVideo;
    [self addChildViewController:video];
    
    // 声音
    FJTopicViewController *voice = [[FJTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = FJTopicTypeVoice;
    [self addChildViewController:voice];
    
    // 图片
    FJTopicViewController * picture = [[FJTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = FJTopicTypePicture;
    [self addChildViewController:picture];
    
    // 段子
    FJTopicViewController *word = [[FJTopicViewController alloc] init];
    word.title = @"段子";
    word.type = FJTopicTypeWord;
    [self addChildViewController:word];
}

- (void)titleClick:(UIButton *)button {
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 标签栏底部指示器
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.fj_width = button.titleLabel.fj_width;
        self.indicatorView.fj_centerX = button.fj_centerX;
    }];
    
    // 切换子控制器
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.fj_width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)tagClick {
    FJRecommendTagsVCTableViewController *vc = [[FJRecommendTagsVCTableViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    FJLog(@"%@", self.navigationController);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.fj_width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.fj_x = scrollView.contentOffset.x;
    // 默认会把y设为20
    vc.view.fj_y = 0;
    // 设置高度
    vc.view.fj_height = scrollView.fj_height;

    
    // 添加到scrollView
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.fj_width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
