//
//  FJCommentHeaderView.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/27.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJCommentHeaderView.h"

@interface FJCommentHeaderView ()

/**
 *  文字标签
 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation FJCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    // 先从缓存池中找header
    FJCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {
        header = [[FJCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = FJRGBColor(223, 223, 223);
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = FJRGBColor(67, 67, 67);
        label.fj_width = 200;
        label.fj_x = FJTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.label.text = title;
}

@end
