//
//  UIBarButtonItem+FJExtension.h
//  百思不得姐
//
//  Created by  高帆 on 16/5/5.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FJExtension)

/**
 *  导航栏添加控件
 *
 *  @param name     默认状态图片名字
 *  @param highName 高亮状态图片名字
 */
+ (instancetype)fj_itemWithImageName:(NSString *)name highImageName:(NSString *)highName target:(id)target action:(SEL)action;
    
@end
