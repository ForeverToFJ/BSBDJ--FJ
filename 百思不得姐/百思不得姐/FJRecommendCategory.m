//
//  FJRecommendCategory.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/6.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJRecommendCategory.h"

@implementation FJRecommendCategory

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
