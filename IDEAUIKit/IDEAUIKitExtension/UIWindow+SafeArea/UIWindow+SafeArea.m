//
//  UIWindow+SafeArea.m
//  UIWindow+SafeArea
//
//  Created by Harry on 2020/1/13.
//

#import "UIWindow+SafeArea.h"

@implementation UIWindow (SafeArea)

+ (UIEdgeInsets)safeArea {
   
   if (@available(iOS 11.0, *)) {
      
      Class UIApplicationClass = NSClassFromString(@"UIApplication");
      
      if (!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
         
         return UIEdgeInsetsZero;
         
      } /* End if () */

      UIApplication  *stApplication = [UIApplication performSelector:@selector(sharedApplication)];
      
      return stApplication.delegate.window.safeAreaInsets;

   } /* End if () */

   return UIEdgeInsetsZero;
}

- (UIEdgeInsets)safeArea {
   
   if (@available(iOS 11.0, *)) {
            
      return self.safeAreaInsets;

   } /* End if () */

   return UIEdgeInsetsZero;
}

@end
