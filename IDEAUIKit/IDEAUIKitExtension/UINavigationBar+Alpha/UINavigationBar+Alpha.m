//
//  UINavigationBar+Alpha.m
//  UINavigationBar+Alpha
//
//  Created by Harry on 2020/1/8.
//  Copyright © 2020 Harry. All rights reserved.
//

#import "UINavigationBar+Alpha.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Alpha)

- (void)setBarTintColorAlpha:(CGFloat)alpha
{
   self.barTintColor = [self.barTintColor colorWithAlphaComponent:alpha];
   
   return;
}

- (void)setBackgroundColorAlpha:(CGFloat)alpha
{
   self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha];

   return;
}

- (void)setBackgroundAlpha:(CGFloat)alpha
{
   UIView *barBackgroundView = self.subviews.firstObject;
   
   if (@available(iOS 11.0, *))
   {   // sometimes we can't change _UIBarBackground alpha
      for (UIView *view in barBackgroundView.subviews)
      {
         view.alpha = alpha;
         
      } /* End for () */
      
   } /* End if () */
   else
   {
      barBackgroundView.alpha = alpha;
      
   } /* End else */

   return;
}

- (void)setTitleColorAlphaWithColor:(UIColor *)titleColor
{
   NSDictionary *titleTextAttributes = [self titleTextAttributes];
   if (titleTextAttributes == nil)
   {
      self.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};

      return;
   }
   NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
   newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
   self.titleTextAttributes = newTitleTextAttributes;

   return;
}

@end
