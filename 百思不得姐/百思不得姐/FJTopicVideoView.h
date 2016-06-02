//
//  FJTopicVideo.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/24.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FJTopic;
@interface FJTopicVideoView : UIView

/**
 *  帖子数据
 */
@property (nonatomic, strong) FJTopic *topic;
+ (instancetype)videoView;

@end
