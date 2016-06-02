//
//  UITextField+PlaceStringColor.m
//  51hs
//
//  Created by king on 16/5/12.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "UITextField+PlaceStringColor.h"
#import <objc/runtime.h>
//#import "UIColor+ColorValue.h"
static char _holder[]="king";

@implementation UITextField (PlaceStringColor)

-(void)setPlaceStringColor:(NSString *)placeStringColor
{
    objc_setAssociatedObject(self, _holder, placeStringColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UITextField *text = (UITextField*)self;
    NSMutableAttributedString *attrSTr = [[NSMutableAttributedString alloc]initWithAttributedString:text.attributedPlaceholder];
    [attrSTr addAttribute:NSForegroundColorAttributeName value:placeStringColor range:NSMakeRange(0,  attrSTr.string.length)];
    self.attributedPlaceholder = attrSTr;
}

-(NSString *)placeStringColor
{
    return objc_getAssociatedObject(self, _holder);
}
@end
