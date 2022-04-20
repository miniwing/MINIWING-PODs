//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import <objc/runtime.h>

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

NSNotificationName   const DKNightVersionThemeChangingNotification   = @"NightVersionThemeChangingNotification";

CGFloat              const DKNightVersionAnimationDuration           = 0.25f;

NSString *           const DKNightVersionCurrentThemeVersionKey      = @"com.idea.nightversion.manager.themeversion";

@interface DKNightVersionManager ()

@end

@implementation DKNightVersionManager

+ (DKNightVersionManager *)sharedManager {
      
   static DKNightVersionManager  *g_INSTANCE = nil;
   static dispatch_once_t         onceToken;
   
   dispatch_once(&onceToken, ^{
      
      LogDebug((@"+[DKNightVersionManager sharedManager] : NSUserDefaults           : %@", [NSUserDefaults standardUserDefaults]));
      
      DKNightVersionManager   *stInstance = (DKNightVersionManager *)objc_getAssociatedObject([NSUserDefaults standardUserDefaults],
                                                                                              (__bridge const void *)([NSUserDefaults standardUserDefaults]) + 0xFFFF);

      if (nil != stInstance) {
         
         g_INSTANCE = stInstance;
         
      } /* End if () */
      else {
       
         g_INSTANCE = [self new];
         
         objc_setAssociatedObject([NSUserDefaults standardUserDefaults],
                                  (__bridge const void *)([NSUserDefaults standardUserDefaults]) + 0xFFFF,
                                  g_INSTANCE,
                                  OBJC_ASSOCIATION_RETAIN_NONATOMIC);

         [[NSNotificationCenter defaultCenter] addObserver:g_INSTANCE
                                                  selector:@selector(__onApplicationWillTerminate:)
                                                      name:UIApplicationWillTerminateNotification
                                                    object:nil];

         LogDebug((@"+[DKNightVersionManager sharedManager] : instance  : %@", g_INSTANCE));

         g_INSTANCE.changeStatusBar       = YES;
         g_INSTANCE.supportsKeyboard      = YES;

         NSUserDefaults *stUserDefaults   = [NSUserDefaults standardUserDefaults];
         DKThemeVersion *szThemeVersion   = [stUserDefaults valueForKey:DKNightVersionCurrentThemeVersionKey];
         szThemeVersion = szThemeVersion ?: DKThemeVersionNormal;
         
         /**
          防止死锁
          */
//         instance.themeVersion            = szThemeVersion;
         g_INSTANCE->_themeVersion        = szThemeVersion;
         __DISPATCH_ASYNC_ON_MAIN_QUEUE(^{
            
            g_INSTANCE.themeVersion       = szThemeVersion;
         });

      } /* End else */
   });
   return g_INSTANCE;
}

+ (DKNightVersionManager *)sharedNightVersionManager {
   
   return [self sharedManager];
}

- (void)__onApplicationWillTerminate:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
      
   objc_setAssociatedObject([NSUserDefaults standardUserDefaults],
                            (__bridge const void *)[NSUserDefaults standardUserDefaults] + 0xFFFF,
                            nil,
                            OBJC_ASSOCIATION_RETAIN_NONATOMIC );

   __CATCH(nErr);
   
   return;
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
   
   __DISPATCH_ASYNC_ON_MAIN_QUEUE(^{

      [[NSNotificationCenter defaultCenter] postNotificationName:DKNightVersionThemeChangingNotification
                                                          object:nil
                                                        userInfo:@{DKNightVersionThemeChangingNotification:aThemeVersion}];
   });
   
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

+ (BOOL)isAppExtension {
   static   BOOL            isAppExtension = NO;
   static   dispatch_once_t onceToken;
   
   dispatch_once(&onceToken, ^{
      
      Class  stClass    = NSClassFromString(@"UIApplication");
      
      if(!stClass || ![stClass respondsToSelector:@selector(sharedApplication)]) {
         
         isAppExtension = YES;
         
      } /* End if () */
      
      if ([[[NSBundle mainBundle] bundlePath] hasSuffix:@".appex"]) {
         
         isAppExtension = YES;
         
      } /* End if () */
   });
   
   return isAppExtension;
}

+ (UIApplication *)sharedExtensionApplication {
   
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
   return [self isAppExtension] ? nil : [UIApplication performSelector:@selector(sharedApplication)];
#pragma clang diagnostic pop
}

@end
