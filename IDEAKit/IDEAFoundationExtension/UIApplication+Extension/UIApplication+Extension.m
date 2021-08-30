//
//  UIApplication+Extension.m
//  IDEAKit
//
//  Created by Harry on 2021/4/29.
//

#import "UIApplication+Extension.h"

@implementation UIApplication (Extension)

#if __has_include(<YYKit/YYKit.h>)
#elif __has_include("YYKit/YYKit.h")
#else
+ (BOOL)isAppExtension {
   static BOOL isAppExtension = NO;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      Class cls = NSClassFromString(@"UIApplication");
      if(!cls || ![cls respondsToSelector:@selector(sharedApplication)]) isAppExtension = YES;
      if ([[[NSBundle mainBundle] bundlePath] hasSuffix:@".appex"]) isAppExtension = YES;
   });
   return isAppExtension;
}

+ (UIApplication *)sharedExtensionApplication {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
   return [self isAppExtension] ? nil : [UIApplication performSelector:@selector(sharedApplication)];
#pragma clang diagnostic pop
}
#endif

+ (BOOL)hasHardwareSafeAreas {
   
   static BOOL hasHardwareSafeAreas = NO;
   
   if (@available(iOS 11.0, *)) {
      
      static BOOL hasCheckedForHardwareSafeAreas = NO;
      static dispatch_once_t onceToken;
      
      if (!hasCheckedForHardwareSafeAreas && [UIApplication sharedExtensionApplication].keyWindow) {
         
         dispatch_once(&onceToken, ^{
            
            UIEdgeInsets insets = [UIApplication sharedExtensionApplication].keyWindow.safeAreaInsets;
            hasHardwareSafeAreas = (insets.top > [UIApplication sharedExtensionApplication].statusBarFrame.size.height ||
                                    insets.left > 0 || insets.bottom > 0 || insets.right > 0);
            
            hasCheckedForHardwareSafeAreas = YES;
         });
         
      } /* End if () */
   }
   
   return hasHardwareSafeAreas;
}

+ (CGFloat)deviceTopSafeAreaInset {
   
   CGFloat topInset = [UIApplication sharedExtensionApplication].statusBarFrame.size.height;
   
   if (@available(iOS 11.0, *)) {
      
      // Devices with hardware safe area insets have fixed insets that depend on the device
      // orientation. On such devices, we aren't interested in the status bar's height because the
      // hardware safe area insets are what ultimately define the margins for the app. If we are
      // running on such a device, we read from the safe area insets instead of the fixed status bar
      // height so that we react to changes in safe area insets (usually due to orientation changes)
      // and update the fixed margin accordingly.
      if ([UIApplication hasHardwareSafeAreas]) {
         UIEdgeInsets insets = [UIApplication sharedExtensionApplication].keyWindow.safeAreaInsets;
         topInset = insets.top;
      }
   }
   return topInset;
}

@end
