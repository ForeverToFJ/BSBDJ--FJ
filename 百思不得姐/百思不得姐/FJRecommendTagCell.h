//
//  FJRecommendTagTableViewCell.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/9.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FJRecommendTag;
@interface FJRecommendTagCell : UITableViewCell
/**
 *  模型数据
 */
@property (nonatomic, strong) FJRecommendTag *recommendTag;
@end
