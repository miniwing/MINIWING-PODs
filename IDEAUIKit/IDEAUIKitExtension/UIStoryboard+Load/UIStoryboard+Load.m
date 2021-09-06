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

#if __UNIVERSAL__
#  define __UNIVERSAL_IPHONE__      __ON__
#  define __UNIVERSAL_IPAD__        __ON__
#else
#  define __UNIVERSAL_IPHONE__      __OFF__
#  define __UNIVERSAL_IPAD__        __OFF__
#endif /* __UNIVERSAL__ */

@implementation UIStoryboard (Load)

+ (NSString *)storyboard:(NSString *)aStoryboard PAD:(BOOL)aPAD;
{
   NSString       *szDevice   = @"";
   
#if __UNIVERSAL_IPAD__
   if (aPAD)
   {
      szDevice = @"_iPad";
      
   } /* end if () */
#  if __UNIVERSAL_IPHONE__
   else
#  endif /* __UNIVERSAL_IPHONE__ */

#endif /* __UNIVERSAL_IPAD__ */
      
#if __UNIVERSAL_IPHONE__
   {
      szDevice = @"_iPhone";
   }
#endif /* __UNIVERSAL_IPHONE__ */
   
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

+ (id)loadStoryboardRoot:(NSString *)aStoryboard
{
   NSString       *szStoryboard  = [UIStoryboard storyboard:aStoryboard
                                                        PAD:[UIDevice currentDevice].isPad];
   UIStoryboard   *stStoryboard  = [UIStoryboard storyboardWithName:szStoryboard
                                                             bundle:nil];
   
   id stView   = [stStoryboard instantiateInitialViewController];
   
   __RELEASE(szStoryboard);
   __RELEASE(stStoryboard);
   
   return stView;
}

- (id)loadViewController:(Class)aClass
{
   return  [self instantiateViewControllerWithIdentifier:NSStringFromClass(aClass)];
}

@end

@implementation UIStoryboard (Framework)

+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass framework:(NSString *)aFramework
{
   NSString       *szStoryboard  = [UIStoryboard storyboard:aStoryboard
                                                        PAD:[UIDevice currentDevice].isPad];
   
   NSString       *szFramework   = nil;
   NSBundle       *stBundle      = nil;
   
   UIStoryboard   *stStoryboard  = nil;
   
   if (aFramework)
   {
      szFramework = [[NSBundle mainBundle] pathForResource:aFramework ofType:nil];
      
   } /* End if () */
   
   if (szFramework)
   {
      stBundle = [NSBundle bundleWithPath:szFramework];
      
   } /* End if () */
   else
   {
      stBundle = [NSBundle mainBundle];
      
   } /* End else */
   
   stStoryboard  = [UIStoryboard storyboardWithName:szStoryboard
                                             bundle:stBundle];
   
   id stView   = [stStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass(aClass)];
   
   __RELEASE(szStoryboard);
   __RELEASE(stStoryboard);
   
   return stView;
}

@end


