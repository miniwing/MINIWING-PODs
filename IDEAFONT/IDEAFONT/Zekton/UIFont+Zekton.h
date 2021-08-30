//
//  UIFont+Zekton.h
//  IDEAFONT
//
//  Created by Harry on 2021/3/10.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <IDEAFONT/IDEASystemFont.h>

#define FONT_ZEKTON                    (1)

@interface UIFont (Zekton)

+ (instancetype)ZektonLightFontOfSize:(CGFloat)size;
+ (instancetype)ZektonRegularFontOfSize:(CGFloat)size;

#if IDEA_FONT_BOLD
+ (instancetype)ZektonBoldFontOfSize:(CGFloat)size;
#endif /* IDEA_FONT_BOLD */

@end

