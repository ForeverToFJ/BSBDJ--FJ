//
//  UIImageView+FJExtension.m
//  百思不得姐
//
//  Created by  高帆 on 16/5/30.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "UIImageView+FJExtension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (FJExtension)

- (void)setIcon:(NSString *)url {
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ?  [image circleImage] : placeholder;
    }];
}

@end
