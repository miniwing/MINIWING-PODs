//
//  UIColor+Dynamic.m
//  IDEAColor
//
//  Created by Harry on 15/1/31.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "IDEAColor.h"
#import "UIColorX+Dynamic.h"

@implementation UIColor (DynamicColor)

+ (UIColor *)colorWithColorLight:(UIColor *)aLight dark:(nullable UIColor *)aDark {
   
   if (@available(iOS 13.0, *)) {
      
      return [self colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
         
         switch (traitCollection.userInterfaceStyle) {
            
         case UIUserInterfaceStyleDark:
            return aDark ?: aLight;
         case UIUserInterfaceStyleLight:
         case UIUserInterfaceStyleUnspecified:
         default:
            return aLight;
            
         } /* End swich () */
      }];
   } /* End if () */
   else {
      return aLight;
      
   } /* End else */
}

- (UIColor *)reverse {
   
   CGFloat r = 0, g, b, a;
   [self getRed:&r green:&g blue:&b alpha:&a];
   
   return [UIColor colorWithRed: 1 - r
                          green: 1 - g
                           blue: 1 - b
                          alpha: a];
}

@end

