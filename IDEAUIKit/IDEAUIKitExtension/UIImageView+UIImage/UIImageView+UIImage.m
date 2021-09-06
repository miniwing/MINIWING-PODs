//
//  UIImageView+UIImage.m
//  UIImageView+UIImage
//
//  Created by Harry on 16/3/2.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "UIImageView+UIImage.h"

@implementation UIImageView (UIImage)

+ (instancetype)imageViewWithImage:(UIImage *)aImage {
   
   return [[UIImageView alloc] initWithImage:aImage];
}

+ (instancetype)imageViewWithNamed:(NSString *)aName {
   
   return [[UIImageView alloc] initWithImage:[UIImage imageNamed:aName]];
}

- (void)setImageNamed:(NSString *)aName {
   
   [self setImage:[UIImage imageNamed:aName]];
   
   return;
}

@end

