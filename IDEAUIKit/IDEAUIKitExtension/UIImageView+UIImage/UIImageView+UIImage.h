//
//  UIImageView+UIImage.h
//  UIImageView+UIImage
//
//  Created by Harry on 16/3/2.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (UIImage)

+ (instancetype)imageViewWithImage:(UIImage *)aImage;
+ (instancetype)imageViewWithNamed:(NSString *)aName;

- (void)setImageNamed:(NSString *)aName;

@end
