//
//  UINavigationBar+Alpha.h
//  UINavigationBar+Alpha
//
//  Created by Harry on 2020/1/8.
//  Copyright © 2020 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Alpha)

- (void)setBarTintColorAlpha:(CGFloat)alpha;
- (void)setBackgroundColorAlpha:(CGFloat)alpha;

- (void)setBackgroundAlpha:(CGFloat)alpha;
- (void)setTitleColorAlphaWithColor:(UIColor *)titleColor;

@end

NS_ASSUME_NONNULL_END
