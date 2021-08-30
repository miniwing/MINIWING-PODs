//
//  UINavigationController+FullscreenPopGesture.h
//  IdeaUIKit
//
//  Created by CiCi on 16/6/3.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (FullscreenPopGesture)

/// The gesture recognizer that actually handles interactive pop.
@property (nonatomic, strong, readonly)   UIPanGestureRecognizer              * fullscreenPopGestureRecognizer;

/// A view controller is able to control navigation bar's appearance by itself,
/// rather than a global way, checking "fd_prefersNavigationBarHidden" property.
/// Default to YES, disable it if you don't want so.
@property (nonatomic, assign)             BOOL                                  viewControllerBasedNavigationBarAppearanceEnabled;

@end

@interface UIViewController (FullscreenPopGesture)

/// Whether the interactive pop gesture is disabled when contained in a navigation
/// stack.
@property (nonatomic, assign)             BOOL                                  interactivePopDisabled;

/// Indicate this view controller prefers its navigation bar hidden or not,
/// checked when view controller based navigation bar's appearance is enabled.
/// Default to NO, bars are more likely to show.
@property (nonatomic, assign)             BOOL                                  prefersNavigationBarHidden;

/// Max allowed initial distance to left edge when you begin the interactive pop
/// gesture. 0 by default, which means it will ignore this limit.
@property (nonatomic, assign)             CGFloat                               interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end
