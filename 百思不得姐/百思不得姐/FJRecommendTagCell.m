//
//  FJRecommendTagTableViewCell.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/9.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJRecommendTagCell.h"
#import "FJRecommendTag.h"
#import "UIImageView+WebCache.h"

@interface FJRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation FJRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(FJRecommendTag *)recommendTag {
    _recommendTag = recommendTag;

    // 头像
    [self.imageListImageView setIcon:recommendTag.image_list];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
    else {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 5;
    frame.size.width = frame.size.width - 10;
    frame.size.height = frame.size.height - 1;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
