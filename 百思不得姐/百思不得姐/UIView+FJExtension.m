//
//  UIView+FJExtension.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/4.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "UIView+FJExtension.h"

@implementation UIView (FJExtension)

- (void)setFj_width:(CGFloat)fj_width {
    CGRect frame = self.frame;
    frame.size.width = fj_width;
    self.frame = frame;
}

- (CGFloat)fj_width {
    return self.frame.size.width;
}

- (void)setFj_height:(CGFloat)fj_height {
    CGRect frame = self.frame;
    frame.size.height = fj_height;
    self.frame = frame;
}

- (CGFloat)fj_height {
    return self.frame.size.height;
}

- (void)setFj_x:(CGFloat)fj_x {
    CGRect frame = self.frame;
    frame.origin.x = fj_x;
    self.frame = frame;
}

- (CGFloat)fj_x {
    return self.frame.origin.x;
}

- (void)setFj_y:(CGFloat)fj_y {
    CGRect frame = self.frame;
    frame.origin.y = fj_y;
    self.frame = frame;
}

- (CGFloat)fj_y {
    return self.frame.origin.y;
}

- (void)setFj_size:(CGSize)fj_size {
    CGRect frame = self.frame;
    frame.size = fj_size;
    self.frame = frame;
}

- (CGSize)fj_size {
    return self.frame.size;
}

- (void)setFj_centerX:(CGFloat)fj_centerX {
    CGPoint center = self.center;
    center.x = fj_centerX;
    self.center = center;
}

- (CGFloat)fj_centerX {
    return self.center.x;
}

- (void)setFj_centerY:(CGFloat)fj_centerY {
    CGPoint center = self.center;
    center.y = fj_centerY;
    self.center = center;
}

- (CGFloat)fj_centerY {
    return self.center.y;
}

- (BOOL)isShowingOnKeyWindow {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    return !self.hidden && self.alpha > 0.01 && self.window == keyWindow && CGRectIntersectsRect(newFrame, winBounds);
}

@end
