//
//  FJRecommendUser.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/6.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJRecommendUser : NSObject

/**
 *  头像
 */
@property (nonatomic, copy) NSString *header;
/**
 *  粉丝数
 */
@property (nonatomic, assign) NSInteger fans_count;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *screen_name;

@end
