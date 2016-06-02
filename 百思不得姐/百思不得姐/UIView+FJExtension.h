//
//  UIView+FJExtension.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/4.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FJExtension)

@property (nonatomic, assign) CGFloat fj_width;
@property (nonatomic, assign) CGFloat fj_height;
@property (nonatomic, assign) CGFloat fj_x;
@property (nonatomic, assign) CGFloat fj_y;
@property (nonatomic, assign) CGSize fj_size;
@property (nonatomic, assign) CGFloat fj_centerX;
@property (nonatomic, assign) CGFloat fj_centerY;

/**
 *  是否在窗口上
 */
- (BOOL)isShowingOnKeyWindow;

@end
