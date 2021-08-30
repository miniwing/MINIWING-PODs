//
//  UIFont+Zekton.m
//  IDEAFONT
//
//  Created by Harry on 2021/3/10.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEAFontLoader.h"
#import "UIFont+Zekton.h"

#import "IDEASystemFont.h"

@implementation UIFont (Zekton)

+ (NSString *)zektonBundle {
   
   return @"IDEAFONTZEKTON";
}

+ (instancetype)ZektonLightFontOfSize:(CGFloat)size {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"Zekton-Light"
                         ofType:@"ttf"
                     fromBundle:UIFont.zektonBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"Zekton-Light" size:size];
}

+ (instancetype)ZektonRegularFontOfSize:(CGFloat)size {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"Zekton-Regular"
                         ofType:@"ttf"
                     fromBundle:UIFont.zektonBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"Zekton" size:size];
}

#if IDEA_FONT_BOLD
+ (instancetype)ZektonBoldFontOfSize:(CGFloat)size {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"Zekton-Bold"
                         ofType:@"ttf"
                     fromBundle:UIFont.zektonBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"Zekton-Bold" size:size];
}
#endif /* IDEA_FONT_BOLD */

@end

