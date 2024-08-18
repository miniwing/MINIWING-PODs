//
//  NSBundle+Kit.m
//  NSBundle+Load
//
//  Created by Harry on 14-7-3.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import <YYKit/UIDevice+YYAdd.h>

#import <IDEAKit/NSString+Java.h>

#import "NSBundle+Load.h"

@implementation NSBundle (Load)

- (UIView *)loadViewWithNib:(NSString *)aNib class:(Class)aClass {
   
   int                            nErr                                     = EFAULT;

   NSString                      *szBundle                                 = nil;
   NSBundle                      *stBundle                                 = nil;
   NSString                      *szIdentifier                             = nil;
   
   UIView                        *stView                                   = nil;
   NSArray<UIView *>             *stViews                                  = nil;

   __TRY;

   /**
    在framework中
    */
   stViews = [self loadNibNamed:aNib
                          owner:nil
                        options:nil];

   for (UIView *stNibView in stViews) {
      
      if ([stNibView isKindOfClass:aClass]) {
         
         stView   = stNibView;
         
         break;
         
      } /* End if () */
      
   } /* End for () */

   __CATCH(nErr);

   return stView;
}

#if 0
- (UIView *)loadViewWithNib:(NSString *)aNib class:(Class)aClass inBundle:(NSString *)aBundle {
   
   int                            nErr                                     = EFAULT;

   NSString                      *szBundle                                 = nil;
   NSBundle                      *stBundle                                 = nil;
   NSString                      *szIdentifier                             = nil;
   
   UIView                        *stView                                   = nil;
   NSArray<UIView *>             *stViews                                  = nil;

   __TRY;

   @try {
      
      /**
       在framework中
       */
      stViews = [self loadNibNamed:aNib
                             owner:nil
                           options:nil];

      for (UIView *stNibView in stViews) {
         
         if ([stNibView isKindOfClass:aClass]) {
            
            stView   = stNibView;
            
            break;
            
         } /* End if () */
         
      } /* End for () */

   } /* End try */
   @catch (NSException *_Exception) {
      
      LogError((@"-[NSBundle loadViewWithNib:class:inBundle:] : NSException : %@", _Exception));

      /**
       在Bundle中
       */
      szBundle = [self pathForResource:aBundle
                                ofType:@"bundle"];
      
      stBundle = [NSBundle bundleWithPath:szBundle];
      
      stViews  = [stBundle loadNibNamed:aNib
                                  owner:nil
                                options:nil];

      for (UIView *stNibView in stViews) {
         
         if ([stNibView isKindOfClass:aClass]) {
            
            stView   = stNibView;
            
            break;
            
         } /* End if () */
         
      } /* End for () */

   } /* End catch (NSException) */
   
   __CATCH(nErr);

   return stView;
}
#endif // 0

@end
