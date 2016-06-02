//
//  NSDate+FJExtension.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/17.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FJExtension)

/**
 *  比较from跟self的时间差
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

@end
