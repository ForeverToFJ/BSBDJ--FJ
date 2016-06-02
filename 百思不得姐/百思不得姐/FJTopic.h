//
//  FJTopic.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/13.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FJComment;
@interface FJTopic : NSObject

/**
 *  用户id
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *profile_image;
/**
 *  内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  发帖时间
 */
@property (nonatomic, copy) NSString *create_time;
/**
 *  顶的数量
 */
@property (nonatomic, assign) NSInteger ding;
/**
 *  踩的数量
 */
@property (nonatomic, assign) NSInteger cai;
/**
 *  转发的数量
 */
@property (nonatomic, assign) NSInteger repost;
/**
 *  评论的数量
 */
@property (nonatomic, assign) NSInteger comment;
/**
 *  上一页的最大时间
 */
@property (nonatomic, copy) NSString *maxtime;
/**
 *  是否新浪加V
 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/**
 *  图片的宽度
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  图片的高度
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  小图片的URL
 */
@property (nonatomic, copy) NSString *small_image;
/**
 *  中图片的URL
 */
@property (nonatomic, copy) NSString *middle_image;
/**
 *  大图片的URL
 */
@property (nonatomic, copy) NSString *large_image;
/**
 *  是否为gif图
 */
@property (nonatomic, assign) BOOL is_gif;
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/**
 *  图片控件的frame
 */
@property (nonatomic, assign, readonly) CGRect pictureViewFrame;
/**
 *  类型
 */
@property (nonatomic, assign) FJTopicType type;
/**
 *  是否为长图
 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/**
 *  图片下载进度
 */
@property (nonatomic, assign) CGFloat pictureProgress;
/**
 *  声音控件的frame
 */
@property (nonatomic, assign, readonly) CGRect voiceViewFrame;
/**
 *  视频控件的frame
 */
@property (nonatomic, assign, readonly) CGRect videoViewFrame;
/**
 *  声音时长
 */
@property (nonatomic, assign) NSInteger voicetime;
/**
 *  视频时长
 */
@property (nonatomic, assign) NSInteger videotime;
/**
 *  播放次数
 */
@property (nonatomic, assign) NSInteger playcount;
/**
 *  声音uri
 */
@property (nonatomic, copy) NSString *voiceuri;
/**
 *  视频uri
 */
@property (nonatomic, copy) NSString *videouri;
/**
 *  最热评论
 */
@property (nonatomic, strong) FJComment *top_cmt;

@end
