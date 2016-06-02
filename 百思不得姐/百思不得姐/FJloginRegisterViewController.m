//
//  FJloginRegisterViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/9.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJloginRegisterViewController.h"

@interface FJloginRegisterViewController ()

/**
 *  登录框距离左边的间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@end

@implementation FJloginRegisterViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
/*
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 带属性的文字 - > 富文本
    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    self.phoneField.attributedPlaceholder = placeholder;
*/    
/*   故事版KVC实现
    // 登录按钮设置圆角
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
*/
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 退出键盘
    [self.view endEditing:YES];
}

- (IBAction)showLoginOrRegister:(id)sender {
    // 退出键盘
    [self.view endEditing:YES];
    
    UIButton *button = (UIButton *)sender;

    if (self.loginViewLeftMargin.constant == 0) { // 显示注册
        
        button.selected = YES;
        
        self.loginViewLeftMargin.constant = -self.view.fj_width;
    }
    else { // 显示登录
        
        button.selected = NO;

        self.loginViewLeftMargin.constant = 0;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)back {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)QQLogin:(id)sender {
    FJLogFunc
}

- (IBAction)sinaLogin:(id)sender {
    FJLogFunc
}

- (IBAction)tecentLogin:(id)sender {
    FJLogFunc
}

/**
 *  让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
