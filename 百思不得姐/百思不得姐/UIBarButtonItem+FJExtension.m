//
//  UIBarButtonItem+FJExtension.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/5.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "UIBarButtonItem+FJExtension.h"

@implementation UIBarButtonItem (FJExtension)

+ (instancetype)fj_itemWithImageName:(NSString *)name highImageName:(NSString *)highName target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highName] forState:UIControlStateHighlighted];
    button.fj_size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end
