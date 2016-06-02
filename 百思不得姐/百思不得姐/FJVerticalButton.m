//
//  FJVerticalButton.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/10.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJVerticalButton.h"

@implementation FJVerticalButton

- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.fj_x = 0;
    self.imageView.fj_y = 0;
//    self.imageView.width = self.width;
//    self.imageView.height = self.width;
    
    // 调整文字
    self.titleLabel.fj_x = 0;
    self.titleLabel.fj_y = self.imageView.fj_height;
    self.titleLabel.fj_width = self.fj_width;
    self.titleLabel.fj_height = self.fj_height - self.titleLabel.fj_y;
}

@end
