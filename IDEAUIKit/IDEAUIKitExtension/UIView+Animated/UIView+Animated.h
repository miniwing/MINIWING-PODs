//
//  UIView+Animated.h
//  UIView+Animated
//
//  Created by Harry on 15/1/16.
//  Copyright (c) 2015年 Harry. All rights reserved.
//
//  Mail:miniwing.hz@gmail.com
//  TEL :+(852)53054612
//

#import <UIKit/UIKit.h>

@interface UIView (Animated)

#if __has_include(<UIKitExtension/UIKitExtension.h>)
#else
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;
#endif

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated duration:(NSTimeInterval)duration;
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated complete:(void(^)(void))aComplete;

@end
