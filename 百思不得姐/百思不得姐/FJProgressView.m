//
//  FJProgressView.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/19.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJProgressView.h"

@implementation FJProgressView

- (void)awakeFromNib {
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    self.progressLabel.text = [NSString stringWithFormat:@"%d%%", (int)(progress * 100)];
}

@end
