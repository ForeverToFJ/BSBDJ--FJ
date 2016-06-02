//
//  FJRecommendCategory.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/6.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJRecommendCategory : NSObject

/**
 *  id
 */
@property (nonatomic, assign) NSInteger ID;
/**
 *  总是
 */
@property (nonatomic, assign) NSInteger count;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  这个类别对应的用户数据
 */
@property (nonatomic, strong) NSMutableArray *users;
/**
 *  总页数
 */
@property (nonatomic, assign) NSInteger total_page;
/**
 *  数据总数
 */
@property (nonatomic, assign) NSInteger total;
/**
 *  下一页
 */
@property (nonatomic, assign) NSInteger next_page;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger current_page;

@end
