//
//  FJCommentHeaderView.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/27.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJCommentHeaderView : UITableViewHeaderFooterView

/**
 *  文字
 */
@property (nonatomic, copy) NSString *title;
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
