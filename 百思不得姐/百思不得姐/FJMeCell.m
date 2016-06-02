//
//  FJMeCell.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/31.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJMeCell.h"

@implementation FJMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.fj_width = 30;
    self.imageView.fj_height = self.imageView.fj_width;
    self.imageView.fj_centerY = self.contentView.fj_height * 0.5;
    
    self.textLabel.fj_x = CGRectGetMaxX(self.imageView.frame) + FJTopicCellMargin;
}
//- (void)setFrame:(CGRect)frame
//{
////    FJLog(@"%@", NSStringFromCGRect(frame));
//    frame.origin.fj_y -= (35 - FJTopicCellMargin);
//    [super setFrame:frame];
//}

@end
