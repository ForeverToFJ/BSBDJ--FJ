//
//  FJCommentViewController.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/25.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FJTopic;
@interface FJCommentViewController : UIViewController

/**
 *  数据模型
 */
@property (nonatomic, strong) FJTopic *topic;

@end
