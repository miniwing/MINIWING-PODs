//
//  UIStoryboard+Kit.m
//  UIStoryboard+Load
//
//  Created by Harry on 14-7-3.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import <YYKit/UIDevice+YYAdd.h>

#import <IDEAKit/NSString+Java.h>

#import "UIStoryboard+Load.h"

#define __UNIVERSAL__               __OFF__

//#if __UNIVERSAL__
//#  define __UNIVERSAL_IPHONE__      __ON__
//#  define __UNIVERSAL_IPAD__        __ON__
//#else
//#  define __UNIVERSAL_IPHONE__      __OFF__
//#  define __UNIVERSAL_IPAD__        __OFF__
//#endif /* __UNIVERSAL__ */

@implementation UIStoryboard (Load)

+ (NSString *)storyboard:(NSString *)aStoryboard PAD:(BOOL)aPAD; {
   
   NSString       *szDevice   = @"";
   
#if __UNIVERSAL__
   
   if (aPAD) {
      
      szDevice = @"_iPad";
      
   } /* End if () */
   else {
      
      szDevice = @"_iPhone";
   
   } /* End else */

#else /* __UNIVERSAL__ */

   szDevice = @"";

#endif /* !__UNIVERSAL__ */
   
   
   return [NSString stringWithFormat:@"%@%@", aStoryboard, szDevice];
}

+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass {
   
   NSString       *szStoryboard  = nil;
   NSString       *szPath        = nil;
   
   NSString       *szBase        = [UIStoryboard storyboard:aStoryboard
                                                        PAD:[UIDevice currentDevice].isPad];
   if (!szPath) {
      
      szStoryboard   = szBase;
      
   } /* End if () */
   
   UIStoryboard   *stStoryboard  = [UIStoryboard storyboardWithName:szStoryboard
                                                             bundle:[NSBundle mainBundle]];
   
   NSString       *szIdentifier  = NSStringFromClass(aClass);
   
   NSArray        *stItems       = [szIdentifier split:@"."];
   
   szIdentifier   = stItems.lastObject;

   id stView   = [stStoryboard instantiateViewControllerWithIdentifier:szIdentifier];
   
   __RELEASE(szStoryboard);
   __RELEASE(stStoryboard);
   
   return stView;
}

+ (NSBundle *)bundleNamed:(NSString *)aBundleName Class:(Class)aClass {
   
   NSBundle *stBaseBundle  = [NSBundle bundleForClass:aClass];
   NSString *szBundlePath  = [stBaseBundle pathForResource:aBundleName ofType:@"bundle"];

   return [NSBundle bundleWithPath:szBundlePath];
}

+ (id)loadStoryboard:(NSString *)aStoryboard identifier:(NSString *)aIdentifier {
   
   NSString       *szStoryboard  = nil;
   NSString       *szPath        = nil;
   
   NSString       *szBase        = [UIStoryboard storyboard:aStoryboard
                                                        PAD:[UIDevice currentDevice].isPad];
   if (!szPath) {
      
      szStoryboard   = szBase;
      
   } /* End if () */
   
   UIStoryboard   *stStoryboard  = [UIStoryboard storyboardWithName:szStoryboard
                                                             bundle:[NSBundle mainBundle]];
   
   NSString       *szIdentifier  = [aIdentifier copy];
   
   NSArray        *stItems       = [szIdentifier split:@"."];
   
   szIdentifier   = stItems.lastObject;

   id stView   = [stStoryboard instantiateViewControllerWithIdentifier:szIdentifier];
   
   __RELEASE(szStoryboard);
   __RELEASE(stStoryboard);
   
   return stView;
}

+ (id)loadStoryboardRoot:(NSString *)aStoryboard {
   
   NSString       *szStoryboard  = [UIStoryboard storyboard:aStoryboard
                                                        PAD:[UIDevice currentDevice].isPad];
   UIStoryboard   *stStoryboard  = [UIStoryboard storyboardWithName:szStoryboard
                                                             bundle:nil];
   
   id stView   = [stStoryboard instantiateInitialViewController];
   
   __RELEASE(szStoryboard);
   __RELEASE(stStoryboard);
   
   return stView;
}

- (id)loadViewController:(Class)aClass {
   
   return  [self instantiateViewControllerWithIdentifier:NSStringFromClass(aClass)];
}

@end

@implementation UIStoryboard (Bundle)

+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass inBundle:(NSString *)aBundle {
   
//   NSBundle       *stBundle      = [NSBundle bundleForClass:aClass];
//
//   UIStoryboard   *stStoryboard  = [UIStoryboard storyboardWithName:aStoryboard
//                                                             bundle:stBundle];
//
//   NSString       *szIdentifier  = NSStringFromClass(aClass);
//
//   NSArray        *stItems       = [szIdentifier split:@"."];
//
//   szIdentifier   = stItems.lastObject;
//
////   id stView   = [stStoryboard instantiateViewControllerWithIdentifier:szIdentifier];
//
//   return [stStoryboard instantiateViewControllerWithIdentifier:szIdentifier];
   
   int                            nErr                                     = EFAULT;
   
   UIStoryboard                  *stStoryboard                             = nil;
   
   NSString                      *szBundle                                 = nil;
   NSBundle                      *stBundle                                 = [NSBundle bundleForClass:aClass];
   NSString                      *szIdentifier                             = nil;
   
   __TRY;

   aStoryboard   = [UIStoryboard storyboard:aStoryboard
                                        PAD:[UIDevice currentDevice].isPad];

   szIdentifier   = NSStringFromClass(aClass);
   
   @try {
      
      stBundle       = [NSBundle bundleForClass:aClass];

      stStoryboard   = [UIStoryboard storyboardWithName:aStoryboard
                                                 bundle:stBundle];
      
   } /* End try */
   @catch (NSException *_Exception) {

      LogDebug((@"+[UIStoryboard loadStoryboard:viewController:inBundle:] : NSException : %@", _Exception));
      
      szBundle       = [[NSBundle mainBundle] pathForResource:aBundle
                                                       ofType:@"framework"];
      
      stBundle       = [NSBundle bundleWithPath:szBundle];
      
      stStoryboard   = [UIStoryboard storyboardWithName:aStoryboard
                                                 bundle:stBundle];

   } /* End catch (NSException) */
   @finally {
      
      NSArray        *stItems       = [szIdentifier split:@"."];

      szIdentifier   = stItems.lastObject;

   } /* End finally */
   
   LogDebug((@"+[UIStoryboard loadStoryboard:viewController:inBundle:] : %@ in %@", szIdentifier, stBundle));

   __CATCH(nErr);
   
   return [stStoryboard instantiateViewControllerWithIdentifier:szIdentifier];
}

@end

@implementation UIStoryboard (Framework)

+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass inFramework:(NSString *)aFramework {
   
   int                            nErr                                     = EFAULT;
   
   UIStoryboard                  *stStoryboard                             = nil;
   
   NSString                      *szBundle                                 = nil;
   NSBundle                      *stBundle                                 = [NSBundle bundleForClass:aClass];
   NSString                      *szIdentifier                             = nil;
   
   __TRY;

   aStoryboard   = [UIStoryboard storyboard:aStoryboard
                                        PAD:[UIDevice currentDevice].isPad];

   szIdentifier   = NSStringFromClass(aClass);
   
   @try {
      
      stBundle       = [NSBundle bundleForClass:aClass];

      stStoryboard   = [UIStoryboard storyboardWithName:aStoryboard
                                                 bundle:stBundle];
      
   } /* End try */
   @catch (NSException *_Exception) {

      LogDebug((@"+[UIStoryboard loadStoryboard:viewController:inFramework:] : NSException : %@", _Exception));
      
      szBundle       = [[NSBundle mainBundle] pathForResource:aFramework
                                                       ofType:@"framework"
                                                  inDirectory:@"Frameworks"];
      
      stBundle       = [NSBundle bundleWithPath:szBundle];
      
      stStoryboard   = [UIStoryboard storyboardWithName:aStoryboard
                                                 bundle:stBundle];

   } /* End catch (NSException) */
   @finally {
      
      NSArray        *stItems       = [szIdentifier split:@"."];

      szIdentifier   = stItems.lastObject;

   } /* End finally */
   
   LogDebug((@"+[UIStoryboard loadStoryboard:viewController:inFramework:] : %@ in %@", szIdentifier, stBundle));

   __CATCH(nErr);
   
   return [stStoryboard instantiateViewControllerWithIdentifier:szIdentifier];
}

@end


