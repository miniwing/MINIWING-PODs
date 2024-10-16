//
//  UIView+Animated.m
//  UIView+Animated
//
//  Created by Harry on 15/11/26.
//  Copyright © 2015年 Harry. All rights reserved.

#import <UIKitExtension/UIKitExtension.h>

#import "IDEAUIKit/UIView+Animated.h"

#if (__has_include(<UIKitExtension/UIKitExtension-umbrella.h>))
#elif (__has_include("UIKitExtension/UIKitExtension-umbrella.h"))
#else
const NSTimeInterval UIAViewAnimationDefaultDuration = 0.25f;
#endif

@implementation UIView (Animated)

#if (__has_include(<UIKitExtension/UIKitExtension-umbrella.h>) || __has_include("UIKitExtension/UIKitExtension-umbrella.h") || __has_include("UIKitExtension.h"))
#else
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
   
   if (!animated || self.hidden == hidden) {
      
      self.hidden = hidden;
      
      return;
   }
   
   CGFloat backupAlpha = self.alpha;
   CGFloat endAlpha;
   
   if (hidden) {
      endAlpha = .0;
   } else {
      self.alpha = .0;
      endAlpha = backupAlpha;
      self.hidden = NO;
   }
   
   [[self class] animateWithDuration:UIView.animationDefaultDuration
                          animations:^(void) {
      self.alpha = endAlpha;
   }
                          completion:^(BOOL isFinished) {
      if (hidden) {
         self.alpha = backupAlpha;
         self.hidden = YES; // value compatibility - this delayed action may be cause of unknown strange behavior.
      }
   }];
}
#endif

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated duration:(NSTimeInterval)duration {
   
   if (!animated || self.hidden == hidden) {
      self.hidden = hidden;
      return;
   }
   
   CGFloat backupAlpha = self.alpha;
   CGFloat endAlpha;
   
   if (hidden) {
      endAlpha = .0;
   }
   else {
      self.alpha = .0;
      endAlpha = backupAlpha;
      self.hidden = NO;
   }
   
   [[self class] animateWithDuration:duration animations:^(void) {
      self.alpha = endAlpha;
   }
                          completion:^(BOOL isFinished) {
      if (hidden) {
         self.alpha = backupAlpha;
         self.hidden = YES; // value compatibility - this delayed action may be cause of unknown strange behavior.
      }
   }];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated complete:(void(^)(void))aComplete {
   
   if (!animated || self.hidden == hidden) {
      
      self.hidden = hidden;
      
      if (aComplete) {
         
         aComplete();
         
      } /* End if () */
      
      return;
   }
   
   CGFloat backupAlpha = self.alpha;
   CGFloat endAlpha;
   
   if (hidden) {
      endAlpha = .0;
   }
   else {
      self.alpha = .0;
      endAlpha = backupAlpha;
      self.hidden = NO;
   }
   
   [[self class] animateWithDuration:UIView.animationDefaultDuration
                          animations:^(void) {
      self.alpha = endAlpha;
   }
                          completion:^(BOOL isFinished) {
      if (hidden) {
         self.alpha = backupAlpha;
         self.hidden = YES; // value compatibility - this delayed action may be cause of unknown strange behavior.
      }
      
      if (aComplete) {
         
         aComplete();
         
      } /* End if () */
   }];
}

@end

