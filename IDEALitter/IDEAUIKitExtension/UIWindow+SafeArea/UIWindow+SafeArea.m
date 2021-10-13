//
//  UIWindow+SafeArea.m
//  TheKiller
//
//  Created by Harry on 2019/8/10.
//  Copyright © 2019 Harry. All rights reserved.
//

#import "UIWindow+SafeArea.h"

@implementation UIWindow (SafeArea)

- (UIEdgeInsets)safeArea
{
   // Comment the following if-statement if you are not running XCode 9+
   if (@available(iOS 11.0, *))
   {
      return [self safeAreaInsets];
      
   } /* End if () */
   
   return UIEdgeInsetsZero;
}

@end
