//
//  UIStoryboard+Kit.m
//  Idea
//
//  Created by Harry on 14-7-3.
//  Copyright (c) 2014年 Harry. All rights reserved.
//



#import "UIStoryboard+Kit.h"




#if __UNIVERSAL__
#  define __UNIVERSAL_IPHONE__      __ON__
#  define __UNIVERSAL_IPAD__        __ON__
#else
#  define __UNIVERSAL_IPHONE__      __OFF__
#  define __UNIVERSAL_IPAD__        __OFF__
#endif /* __UNIVERSAL__ */




@implementation UIStoryboard (UIViewController)

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

+ (id)loadStoryboard:(NSString *)aStoryboard viewController:(Class)aClass
{
   NSString       *szStoryboard  = nil;
   NSString       *szPath        = nil;
   
   NSString       *szBase        = [UIStoryboard storyboard:aStoryboard
                                                        PAD:IS_IPAD];
   if (!szPath)
   {
      szStoryboard   = szBase;
      
   } /* End if () */
   
   
   UIStoryboard   *stStoryboard  = [UIStoryboard storyboardWithName:szStoryboard
                                                             bundle:[NSBundle mainBundle]];
   
   id stView   = [stStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass(aClass)];
   
#if __has_feature(objc_arc)
#else
   [stStoryboard release];
#endif
   
   return stView;
}

+ (id)loadStoryboardRoot:(NSString *)aStoryboard
{
   NSString       *szStoryboard  = [UIStoryboard storyboard:aStoryboard
                                                        PAD:IS_IPAD];
   UIStoryboard   *stStoryboard  = [UIStoryboard storyboardWithName:szStoryboard
                                                             bundle:nil];
   
   id stView   = [stStoryboard instantiateInitialViewController];
   
#if __has_feature(objc_arc)
#else
   [szStoryboard release];
   [stStoryboard release];
#endif

   return stView;
}

- (id)loadViewController:(Class)aClass
{
   return  [self instantiateViewControllerWithIdentifier:NSStringFromClass(aClass)];
}

@end

