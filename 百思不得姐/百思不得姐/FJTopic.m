//
//  FJTopic.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/13.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTopic.h"
#import "NSDate+FJExtension.h"
#import "MJExtension.h"
#import "FJComment.h"
#import "FJUser.h"

@implementation FJTopic
{
    CGFloat _cellHeight;
//    CGRect _pictureViewFrame;
//    CGRect _voiceViewFrame;
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

//+ (NSDictionary *)mj_objectClassInArray {
//    return @{@"top_cmt" : @"FJComment"};
//}

- (CGFloat)cellHeight {
    
    if (!_cellHeight) {
        // 文字
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * FJTopicCellMargin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        _cellHeight = textH + FJTopicCellTextY + FJTopicCellBottomBarH + FJTopicCellMargin;
        
        // 判断类型
        if (self.type == FJTopicTypePicture) {
            if (self.width != 0 && self.height != 0) {
                CGFloat pictureX = FJTopicCellMargin;
                CGFloat pictureY = FJTopicCellTextY + textH + FJTopicCellMargin;
                CGFloat pictureW = maxSize.width;
                CGFloat pictureH = pictureW * self.height / self.width;
                
                if (pictureH >= FJTopicCellPictureMaxH) {
                    pictureH = FJTopicCellPictureBreakH;
                    self.bigPicture = YES;
                }
            
                _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
                _cellHeight += pictureH + FJTopicCellMargin;
            }
        }
        else if (self.type == FJTopicTypeVoice) {
            if (self.width != 0 && self.height != 0) {
                CGFloat voiceX = FJTopicCellMargin;
                CGFloat voiceY = FJTopicCellTextY + textH + FJTopicCellMargin;
                CGFloat voiceW = maxSize.width;
                CGFloat voiceH = voiceW * self.height / self.width;
                
                _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
                _cellHeight += voiceH + FJTopicCellMargin;
            }
        }
        else if (self.type == FJTopicTypeVideo) {
            if (self.width != 0 && self.height != 0) {
                CGFloat videoX = FJTopicCellMargin;
                CGFloat videoY = FJTopicCellTextY + textH + FJTopicCellMargin;
                CGFloat videoW = maxSize.width;
                CGFloat videoH = videoW * self.height / self.width;
                
                _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
                _cellHeight += videoH + FJTopicCellMargin;
            }
        }
        
        // 最热评论
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;;
            _cellHeight += FJTopicCellTopCmtTitleH + contentH + FJTopicCellMargin;
        }
        
        _cellHeight += FJTopicCellMargin;
    }
    return _cellHeight;
}

@end
