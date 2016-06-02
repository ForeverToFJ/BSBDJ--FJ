//
//  FJRecommendCategoryCell.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/6.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJRecommendCategoryCell.h"
#import "FJRecommendCategory.h"

@interface FJRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *text;
// 选中时显示的指示器控件
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation FJRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = FJRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = FJRGBColor(219, 21, 26);
//    self.text.textColor = FJRGBColor(78, 78, 78);
//    self.text.highlightedTextColor = FJRGBColor(219, 21, 26);
//    self.selectedBackgroundView = [UIView new];
}

- (void)setCategory:(FJRecommendCategory *)category {
    _category = category;
    
    self.text.text = category.name;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    self.textLabel.height = self.contentView.height - 2;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.text.textColor = selected ? FJRGBColor(219, 21, 26) : FJRGBColor(78, 78, 78);
}

@end
