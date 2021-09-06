//
//  UIColor+Dynamic.h
//  IDEAColor
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

// https://noahgilmore.com/blog/dark-mode-uicolor-compatibility/

@interface UIColor (DynamicColor)

//+ (UIColor *)colorWithProvider:(UIColor * (^)(UITraitCollection *aTraitCollection))dynamicProvider light:(UIColor *)aLightColor dark:(UIColor *)aDarkColor;

+ (nonnull UIColor *)colorWithColorLight:(nonnull UIColor *)aLightColor dark:(nullable UIColor *)aDarkColor;

- (nonnull UIColor *)reverse;

@end
