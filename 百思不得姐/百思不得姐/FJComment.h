//
//  FJcomment.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/25.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FJUser;
@interface FJComment : NSObject

/**
 *  ID
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  音频评论时长
 */
@property (nonatomic, assign) NSInteger voicetime;
/**
 *  音频url
 */
@property (nonatomic, copy) NSString *voiceuri;
/**
 *  文字
 */
@property (nonatomic, copy) NSString *content;
/**
 *  点赞数
 */
@property (nonatomic, assign) NSInteger like_count;
/**
 *  用户
 */
@property (nonatomic, strong) FJUser *user;

@end
