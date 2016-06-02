//
//  FJTopicCell.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/16.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTopicCell.h"
#import "FJTopic.h"
#import "UIImageView+WebCache.h"
#import "NSDate+FJExtension.h"
#import "FJTopicPictureView.h"
#import "FJTopicVoiceView.h"
#import "FJTopicVideoView.h"
#import "FJComment.h"
#import "FJUser.h"
#import "UIImage+FJExtension.h"

@interface FJTopicCell ()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *create_time;
/**
 *  顶
 */
@property (weak, nonatomic) IBOutlet UIButton *ding;
/**
 *  踩
 */
@property (weak, nonatomic) IBOutlet UIButton *cai;
/**
 *  分享
 */
@property (weak, nonatomic) IBOutlet UIButton *share;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *comment;
/**
 *  新浪加V
 */
@property (weak, nonatomic) IBOutlet UIImageView *sinaV;
/**
 *  文字
 */
@property (weak, nonatomic) IBOutlet UILabel *text;
/**
 *  图片帖子中间的内容
 */
@property (nonatomic, weak) FJTopicPictureView *pictureView;
/**
 *  声音
 */
@property (nonatomic, weak) FJTopicVoiceView *voiceView;
/**
 *  视频
 */
@property (nonatomic, weak) FJTopicVideoView *videoView;
/**
 *  最热评论的View
 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/**
 *  最热评论的内容
 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtText;

@end

@implementation FJTopicCell

+ (instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

#pragma makrk - 懒加载
- (FJTopicPictureView *)pictureView {
    if (!_pictureView) {
        FJTopicPictureView *pictureView = [FJTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (FJTopicVoiceView *)voiceView {
    if (!_voiceView) {
        FJTopicVoiceView *voiceView = [FJTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (FJTopicVideoView *)videoView {
    if (!_videoView) {
        FJTopicVideoView *videoView = [FJTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)setTopic:(FJTopic *)topic {
    _topic = topic;
    
    // 新浪加V
    self.sinaV.hidden = !topic.isSina_v;
    
    // 头像
    [self.profile_image setIcon:topic.profile_image];
    
    // 昵称
    self.name.text = topic.name;
    
    // 文字
    self.text.text = topic.text;
    
    // 时间
    /**
     今年
     今天
     一分钟内
     刚刚
     一小时内
     XX分钟前
     其他
     XX小时前
     昨天
     昨天 HH:mm:ss
     其他
     MM-dd HH:mm:ss
     非今年
     yyyy-MM-dd HH:mm:ss
     */
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 发帖时间
    NSDate *create = [fmt dateFromString:topic.create_time];
//    NSLog(@"%@", create);
    // 今年
    if (create.isThisYear) {
        // 今天
        if (create.isToday) {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            // 其他
            if (cmps.hour >= 1) {
                self.create_time.text = [NSString stringWithFormat:@"%zd分钟前", cmps.hour];
            }
            // 1小时内
            else if (cmps.minute >= 1) {
                self.create_time.text = [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }
            // 1分钟内
            else {
                self.create_time.text = @"刚刚";
            }
        }
        // 昨天
        else if (create.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            self.create_time.text = [fmt stringFromDate:create];
        }
        // 其他
        else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            self.create_time.text = [fmt stringFromDate:create];
        }
    }
    // 非今年
    else {
        self.create_time.text = topic.create_time;
    }

    // 设置底部按钮
    [self setupButtonTitle:self.ding count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.cai count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.share count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.comment count:topic.comment placeholder:@"评论"];
    
    // 根据帖子类型添加中间模块
    if (topic.type == FJTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    else if (topic.type == FJTopicTypeVoice) {
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceViewFrame;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }
    else if (topic.type == FJTopicTypeVideo) {
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewFrame;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    else if (topic.type == FJTopicTypeWord) {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    // 处理最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtText.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    }
    else {
        self.topCmtView.hidden = YES;
    }
}

/*
- (void)testDate:(NSString *)create_time {
    // 当前时间
    NSDate *nowTime = [NSDate date];
    // 发帖时间 NSString -> NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:create_time];
    NSTimeInterval delta = [create timeIntervalSinceDate:nowTime];
}
*/

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    NSString *title = [self buttonCount:count placeholder:placeholder];
    [button setTitle:title forState:UIControlStateNormal];
}

- (NSString *)buttonCount:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    }
    else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    return placeholder;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = FJTopicCellMargin;
    frame.origin.y = frame.origin.y + FJTopicCellMargin;;
    frame.size.width = frame.size.width - FJTopicCellMargin * 2;
//    frame.size.height = frame.size.height - FJTopicCellMargin;
    frame.size.height = self.topic.cellHeight - FJTopicCellMargin;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;//点击cell没点击阴影效果
//    self.userInteractionEnabled = NO;//设置cell不能点击
    
    // 头像圆角
//    self.profile_image.layer.cornerRadius = self.profile_image.fj_width * 0.5;
//    self.profile_image.layer.masksToBounds = YES;

    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)more {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
}

@end
