//
//  UIFont+SFUI.m
//  IDEAFONT
//
//  Created by Harry on 2021/3/10.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEAFontLoader.h"
#import "UIFont+SFUI.h"

@implementation UIFont (SFUI)


+ (instancetype)SFUILightFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"SF-UI-Text-Light"
                         ofType:@"otf"
                     fromBundle:IDEAFontLoader.bundle
                      onceToken:&onceToken];
   return [self fontWithName:@"SF-UI-Text-Light" size:aSize];
}


+ (instancetype)SFUIRegularFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"SF-UI-Text-Regular"
                         ofType:@"otf"
                     fromBundle:IDEAFontLoader.bundle
                      onceToken:&onceToken];
   return [self fontWithName:@"SF-UI-Text-Regular" size:aSize];
}


+ (instancetype)SFUIBoldFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"SF-UI-Text-Semibold"
                         ofType:@"otf"
                     fromBundle:IDEAFontLoader.bundle
                      onceToken:&onceToken];
   return [self fontWithName:@"SF-UI-Text-Semibold" size:aSize];
}


@end

