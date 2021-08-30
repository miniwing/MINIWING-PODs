//
//  UIFont+HY.h
//  IDEAFONT
//
//  Created by Harry on 2021/3/10.
//  Copyright © 2021 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <IDEAFONT/IDEASystemFont.h>

#define FONT_HY                        (1)

@interface UIFont (HY)

+ (instancetype)HYLightFontOfSize:(CGFloat)aSize;
+ (instancetype)HYRegularFontOfSize:(CGFloat)aSize;

#if IDEA_FONT_BOLD
+ (instancetype)HYBoldFontOfSize:(CGFloat)aSize;
#endif /* IDEA_FONT_BOLD */

@end

