//
//  NSObject+Null.m
//  IDEALitter
//
//  Created by Harry on 14-8-12.
//  Copyright (c) 2014年 Idea.Mobi. All rights reserved.
//

#import "IDEALitter/NSObject+Null.h"
#import "IDEALitter/NSString+Java.h"

@implementation NSObject (Null)

- (BOOL)isNull {
   
   BOOL         bNULL   = YES;
   
   if (nil != self) {
      
      if (self != [NSNull null]) {
         
         if ([self isKindOfClass:[NSString class]]) {
            
            if (![(NSString *)self contains:@"null"] && [(NSString *)self length]) {
               
               bNULL = NO;
               
            } /* End if () */
            
         } /* End if () */
         else {
            
            bNULL = NO;
            
         } /* End else */
         
      } /* End if () */
      
   } /* End if () */
   
   return bNULL;
}

@end

@implementation NSString (Empty)

- (BOOL)isEmpty {
   
   if (nil == self || 0 == self.length) {
      
      return YES;
      
   } /* End if () */
   
   return NO;
}

- (BOOL)isBlank {
   
   NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
   
   return [[self stringByTrimmingCharactersInSet:set] isEmpty];
}

@end

