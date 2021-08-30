//
//  UIFont+HY.m
//  IDEAFONT
//
//  Created by Harry on 2021/3/10.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEASystemFont.h"
#import "IDEAFontLoader.h"
#import "UIFont+HY.h"

@implementation UIFont (HY)

+ (NSString *)hyBundle {
   
   return @"IDEAFONTHY";
}

+ (instancetype)HYLightFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"HY-Light"
                         ofType:@"ttf"
                     fromBundle:UIFont.hyBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"HY-Light" size:aSize];
}

+ (instancetype)HYRegularFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"HY-Regular"
                         ofType:@"ttf"
                     fromBundle:UIFont.hyBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"HY-Regular" size:aSize];
}

#if IDEA_FONT_BOLD
+ (instancetype)HYBoldFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"HY-Bold"
                         ofType:@"ttf"
                     fromBundle:UIFont.hyBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"HY-Bold" size:aSize];
}
#endif /* IDEA_FONT_BOLD */

@end

