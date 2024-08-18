//
//  UIAlertAction+Color.m
//  UIAlertAction+Color
//
//  Created by Harry on 15/11/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "NSObject+Ivar.h"
#import "UIAlertAction+Color.h"

@implementation UIAlertAction (Color)

- (BOOL)isPropertyExisted:(NSString *)aProperty {
   
   static NSMutableDictionary<NSString *, NSNumber *> *stProperties  = nil;
   static dispatch_once_t                              onceToken;
   dispatch_once(&onceToken, ^{
      
      stProperties   = [NSMutableDictionary<NSString *, NSNumber *> dictionary];
      NSArray<NSString *> *stIvarNames = [self getAllIvarNames];
      
      for (NSString *szName in stIvarNames) {
         
         LogDebug((@"-[UIAlertAction isPropertyExisted:] : Property : %@", szName));
         
         [stProperties setObject:@(YES) forKey:szName];
         
      } /* End for () */

      return;
   });
   
   return [[stProperties objectForKey:aProperty] boolValue];
}

- (void)setTitleColor:(UIColor *)aColor {
   
   if ([self isPropertyExisted:@"_titleTextColor"]) {
      
      [self setValue:aColor forKey:@"_titleTextColor"];
      
   } /* End if () */
   
   return;
}

@end
