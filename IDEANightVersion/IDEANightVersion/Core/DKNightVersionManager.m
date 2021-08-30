//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "DKNightVersionManager.h"

NSString *  const DKThemeVersionNormal                      = @"NORMAL";
NSString *  const DKThemeVersionNight                       = @"NIGHT";

//#if __has_include(<UIKitExtension/UIKitExtension.h>)
//#  import <UIKitExtension/UIKitExtension.h>
//CGFloat     const DKNightVersionAnimationDuration           = UIAViewAnimationDefaultDuraton;
////CGFloat     const DKNightVersionAnimationDuration           = 3.0f;
//#elif __has_include("UIKitExtension/UIKitExtension.h")
//#  import "UIKitExtension/UIKitExtension.h"
//CGFloat     const DKNightVersionAnimationDuration           = UIAViewAnimationDefaultDuraton;
//#else
////CGFloat     const DKNightVersionAnimationDuration           = 0.3f;
//#endif

NSNotificationName   const DKNightVersionThemeChangingNotification   = @"DKNightVersionThemeChangingNotification";

CGFloat              const DKNightVersionAnimationDuration           = 0.25f;

NSString *           const DKNightVersionCurrentThemeVersionKey      = @"com.idea.nightversion.manager.themeversion";

@interface DKNightVersionManager ()

@end

@implementation DKNightVersionManager

+ (DKNightVersionManager *)sharedManager {
   static dispatch_once_t         onceToken;
   static DKNightVersionManager  *instance;
   dispatch_once(&onceToken, ^{
      instance = [self new];
      instance.changeStatusBar      = YES;
      NSUserDefaults *userDefaults  = [NSUserDefaults standardUserDefaults];
      DKThemeVersion *themeVersion  = [userDefaults valueForKey:DKNightVersionCurrentThemeVersionKey];
      themeVersion = themeVersion ?: DKThemeVersionNormal;
      instance.themeVersion         = themeVersion;
      instance.supportsKeyboard     = YES;
   });
   return instance;
}

+ (DKNightVersionManager *)sharedNightVersionManager {
   
   return [self sharedManager];
}

- (void)nightFalling {
   
   self.themeVersion = DKThemeVersionNight;
   
   return;
}

- (void)dawnComing {
   
   self.themeVersion = DKThemeVersionNormal;
   
   return;
}

- (void)setThemeVersion:(DKThemeVersion *)aThemeVersion {
   
   if ([_themeVersion isEqualToString:aThemeVersion]) {
      
      // if type does not change, don't execute code below to enhance performance.
      return;
   }
   _themeVersion = aThemeVersion;
   
   // Save current theme version to user default
   [[NSUserDefaults standardUserDefaults] setValue:aThemeVersion forKey:DKNightVersionCurrentThemeVersionKey];
   [[NSUserDefaults standardUserDefaults] synchronize];
   
   [[NSNotificationCenter defaultCenter] postNotificationName:DKNightVersionThemeChangingNotification
                                                       object:aThemeVersion];
   
   if (self.shouldChangeStatusBar) {
      
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
      Class stUIApplicationClass = NSClassFromString(@"UIApplication");
      if (!stUIApplicationClass || ![stUIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
         
         return;
      }
      
      UIApplication  *stApplication = [UIApplication performSelector:@selector(sharedApplication)];
      /* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
      
      if ([aThemeVersion isEqualToString:DKThemeVersionNight]) {
         
         [stApplication setStatusBarStyle:UIStatusBarStyleLightContent];
         
      } /* End if () */
      else {
         
         if (@available(iOS 13.0, *)) {
            
            [stApplication setStatusBarStyle:UIStatusBarStyleDarkContent];
            
         } /* End if () */
         else {
            
            [stApplication setStatusBarStyle:UIStatusBarStyleDefault];
            
         } /* End else */
         
      } /* End else */
#pragma clang diagnostic pop
      
   } /* End if () */
   
   return;
}

@end
