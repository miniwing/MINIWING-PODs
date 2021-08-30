//
//  UIFont+MSYH.m
//  IDEAFONT
//
//  Created by Harry on 2021/3/10.
//  Copyright © 2021 Harry. All rights reserved.
//

#import "IDEAFontLoader.h"
#import "UIFont+MSYH.h"

@implementation UIFont (MSYH)

// 'MicrosoftYaHeiHeavy'
// 'MicrosoftYaHei-Bold'
// 'MicrosoftYaHeiSemibold'
// 'MicrosoftYaHeiSemilight'
// 'MicrosoftYaHei'
// 'MicrosoftYaHeiLight'

+ (NSString *)msyhBundle {
   
   return @"IDEAFONTMSYH";
}

+ (instancetype)MSYHLightFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"msyhsl"
                         ofType:@"ttc"
                     fromBundle:UIFont.msyhBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"MicrosoftYaHeiSemilight" size:aSize];
}

+ (instancetype)MSYHRegularFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"msyh"
                         ofType:@"ttc"
                     fromBundle:UIFont.msyhBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"MicrosoftYaHei" size:aSize];
}

+ (instancetype)MSYHBoldFontOfSize:(CGFloat)aSize {
   
   static dispatch_once_t onceToken;
   [IDEAFontLoader loadFontFile:@"msyhsb"
                         ofType:@"ttc"
                     fromBundle:UIFont.msyhBundle
                      onceToken:&onceToken];
   return [self fontWithName:@"MicrosoftYaHeiSemibold" size:aSize];
}

@end

