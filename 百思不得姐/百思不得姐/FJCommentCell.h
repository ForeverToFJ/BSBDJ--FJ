//
//  FJCommentCell.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/27.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FJComment;
@interface FJCommentCell : UITableViewCell

/**
 *  评论模型
 */
@property (nonatomic, strong) FJComment *comment;

@end
