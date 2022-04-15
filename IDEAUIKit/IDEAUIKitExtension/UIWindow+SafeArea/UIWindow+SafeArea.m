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

static const CGFloat __FixedStatusBarHeightOnPreiPhoneXDevices = 20;

+ (CGFloat)topSafeAreaInset {
   
   CGFloat topInset = __FixedStatusBarHeightOnPreiPhoneXDevices;
   
   if (@available(iOS 11.0, *)) {
      
     // Devices with hardware safe area insets have fixed insets that depend on the device
     // orientation. On such devices, we aren't interested in the status bar's height because the
     // hardware safe area insets are what ultimately define the margins for the app. If we are
     // running on such a device, we read from the safe area insets instead of the fixed status bar
     // height so that we react to changes in safe area insets (usually due to orientation changes)
     // and update the fixed margin accordingly.
      UIEdgeInsets insets = [UIWindow safeArea];
      topInset = insets.top;
   }
   return topInset;
 }

@end
