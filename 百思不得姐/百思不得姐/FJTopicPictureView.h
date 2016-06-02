//
//  FJTopicPictureView.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/18.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FJTopic;
@interface FJTopicPictureView : UIView

/**
 *  帖子数据
 */
@property (nonatomic, strong) FJTopic *topic;

+ (instancetype)pictureView;

@end
