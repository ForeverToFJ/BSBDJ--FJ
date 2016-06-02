//
//  FJLabel.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/30.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJLabel.h"

@implementation FJLabel

- (void)awakeFromNib {
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)copy:(UIMenuController *)menu {
    
    // 复制到粘贴板
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
}

- (void)cut:(UIMenuController *)menu {
    
    // 复制到粘贴板
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
    
    // 清空文字
    self.text = nil;
}

- (void)paste:(UIMenuController *)menu {
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    self.text = board.string;
}

- (void)setup {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

/**
 *  label能执行哪些操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    NSLog(@"%@", NSStringFromSelector(action));
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
}

- (void)labelClick {
    // 让label成为第一响应者
    [self becomeFirstResponder];
    
    // 显示MenuController
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 自定义
//    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    
    // 显示的位置
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
}

@end
