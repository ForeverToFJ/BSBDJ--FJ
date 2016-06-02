//
//  FJRecommendUserCell.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/6.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJRecommendUserCell.h"
#import "FJRecommendUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+FJExtension.h"

@interface FJRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation FJRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(FJRecommendUser *)user {
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%ld人关注", user.fans_count];
    }
    else {
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    
    // 头像
    [self.headerImageView setIcon:user.header];
}

@end
