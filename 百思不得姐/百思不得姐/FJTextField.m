//
//  FJTextField.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/11.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJTextField.h"
#import <objc/runtime.h>
#import "UITextField+PlaceStringColor.h"

@interface FJTextField ()<UITextFieldDelegate>

@end

@implementation FJTextField

+ (void)initialize {
    
    unsigned int count = 0;
    // 拷贝出所有的成员变量列表
//    objc_property_t *propertyList = class_copyPropertyList([UITextField class], &count);
    Ivar *ivars = class_copyIvarList([UITabBar class], &count);
    
    for (int i = 0; i < count; i++) {
        // 取出成员变量
//        objc_property_t property = propertyList[i];
        Ivar ivar = ivars[i];
        
        // 获取属性名
//        const char *propertyName = property_getName(property);
//        NSString *name = [NSString stringWithUTF8String:propertyName];
        // 打印成员变量名字
//        NSLog(@"%@", name);
//        NSLog(@"name:%s", ivar_getName(ivar));
    }
    
    // 释放
//    free(propertyList);
    free(ivars);
}

- (void)awakeFromNib {

    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 光标颜色
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder {
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

//#pragma mark - UITextFieldDelegate
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
////    self.placeStringColor = [UIColor whiteColor];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
////    self.placeStringColor = [UIColor grayColor];
//}
@end
