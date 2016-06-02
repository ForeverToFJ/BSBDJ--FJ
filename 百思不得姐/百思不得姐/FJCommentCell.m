//
//  FJCommentCell.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/27.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJCommentCell.h"
#import "FJComment.h"
#import "FJUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+FJExtension.h"

@interface FJCommentCell ()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**
 *  点赞数
 */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
/**
 *  语音评论
 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation FJCommentCell

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
    //    self.selectionStyle = UITableViewCellSelectionStyleNone;//点击cell没点击阴影效果
    //    self.userInteractionEnabled = NO;//设置cell不能点击
    
    // 头像圆角
//    self.profileImageView.layer.cornerRadius = self.profileImageView.fj_width * 0.5;
//    self.profileImageView.layer.masksToBounds = YES;
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(FJComment *)comment {
    _comment = comment;
    
    // 头像
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImageView.image = image ?  [image circleImage] : placeholder;
    }];
    [self.profileImageView setIcon:comment.user.profile_image];
    
    // 性别
    self.sexImageView.image = [comment.user.sex isEqualToString:FJUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    
    // 内容
    self.contentLabel.text = comment.content;
    
    // 用户名
    self.usernameLabel.text = comment.user.username;
    
    // 点赞数
    NSString *likeCount;
    if (comment.like_count < 10000) {
        likeCount = [NSString stringWithFormat:@"%zd", comment.like_count];
    }
    else {
        likeCount = [NSString stringWithFormat:@"%.1f万", comment.like_count / 10000.0];
    }
    self.likeCountLabel.text = likeCount;
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
//        self.contentLabel.hidden = YES;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd″", comment.voicetime] forState:UIControlStateNormal];
    }
    else {
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = FJTopicCellMargin;
    frame.size.width -= 2 * FJTopicCellMargin;
    
    [super setFrame:frame];
}

@end
