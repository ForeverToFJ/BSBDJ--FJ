//
//  FJSqaureButton.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/31.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJSqaureButton.h"
#import "FJSquare.h"
#import "UIButton+WebCache.h"

@implementation FJSqaureButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.fj_y = self.fj_height * 0.15;
    self.imageView.fj_width = self.fj_width * 0.5;
    self.imageView.fj_height = self.imageView.fj_width;
    self.imageView.fj_centerX = self.fj_width * 0.5;
    
    // 调整文字
    self.titleLabel.fj_x = 0;
    self.titleLabel.fj_y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.fj_width = self.fj_width;
    self.titleLabel.fj_height = self.fj_height - self.titleLabel.fj_y;
}

- (void)setSquare:(FJSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    // 利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}



@end
