//
//  NSObject+Ivar.m
//  IDEAKit
//
//  Created by Harry on 14-8-12.
//  Copyright (c) 2014年 Idea.Mobi. All rights reserved.
//

#import "NSObject+Ivar.h"

@implementation NSObject (Ivar)

- (NSArray *)getAllIvar {
   
   NSMutableArray *array   = [NSMutableArray array];
   unsigned int    count   = 0;
   
   Ivar *stIvars = class_copyIvarList([self class], &count);
   
   for (int H = 0; H < count; H++) {
      
      Ivar ivar = stIvars[H];
      
      const char *keyChar = ivar_getName(ivar);
      
      NSString *keyStr = [NSString stringWithCString:keyChar encoding:NSUTF8StringEncoding];
      
      @try {
         id valueStr = [self valueForKey:keyStr];
         NSDictionary *dic = nil;
         if (valueStr) {
            dic = @{keyStr : valueStr};
         }
         else {
            dic = @{keyStr : @"nil"};
         }
         [array addObject:dic];
      }
      @catch (NSException *exception) {
         LogError((@"-[NSObject getAllIvar] : NSException : %@", exception));
      }
   }
   return [array copy];
}

- (NSArray<NSString *> *)getAllIvarNames {
   
   NSMutableArray *stIvarNames   = [NSMutableArray array];
   unsigned int    nCount        = 0;
   Ivar           *stIvars       = class_copyIvarList([self class], &nCount);
   
   for (int H = 0; H < nCount; H++) {
      const char  *szIvarName    = ivar_getName(stIvars[H]);
      NSString    *szName        = [NSString stringWithCString:szIvarName
                                                      encoding:NSUTF8StringEncoding];
      [stIvarNames addObject:szName];
      
   } /* End for () */
   
   return [stIvarNames copy];
}

//获得所有属性
- (NSArray *)getAllProperty {
   
   NSMutableArray *array   = [NSMutableArray array];
   unsigned int    count   = 0;
   
   objc_property_t *propertys = class_copyPropertyList([self class], &count);
   
   for (int H = 0; H < count; H++) {
      
      objc_property_t property = propertys[H];
      const char *nameChar = property_getName(property);
      NSString *nameStr = [NSString stringWithCString:nameChar encoding:NSUTF8StringEncoding];
      [array addObject:nameStr];
      
   } /* End for () */
   
   return [array copy];
}

@end

