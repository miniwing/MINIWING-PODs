//
//  NSArray+Extension.m
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>

#import "NSArray+EventKit.h"
#import "NSObject+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSArray (EventKit)

- (id)serialize {
   
   if (0 == [self count]) {
      
      return nil;
      
   } /* End if () */
   
   NSMutableArray *stArray = [NSMutableArray array];
   
   for (NSObject * element in self) {
      
      [stArray addObject:[element serialize]];
      
   } /* End for () */
   
   return stArray;
}

- (void)unserialize:(id)aObject {
   
   return;
}

- (void)zerolize {
   
   return;
}

- (NSArray *)head:(NSUInteger)aCount {
   
   if (0 == self.count || 0 == aCount) {
      
      return nil;
      
   } /* End if () */
   
   if (self.count < aCount) {
      
      return self;
      
   } /* End if () */
   
   NSRange   stRange;
   stRange.location  = 0;
   stRange.length    = aCount;
   
   return [self subarrayWithRange:stRange];
}

- (NSArray *)tail:(NSUInteger)aCount
{   
   if (0 == self.count || 0 == aCount) {
      
      return nil;
      
   } /* End if () */
   
   if (self.count < aCount) {
      
      return self;
      
   } /* End if () */
   
   NSRange   stRange;
   stRange.location  = self.count - aCount;
   stRange.length    = aCount;
   
   return [self subarrayWithRange:stRange];
}

- (NSString *)join {
   
   return [self join:nil];
}

- (NSString *)join:(NSString *)aDelimiter {
   
   if (0 == self.count) {
      
      return @"";
      
   } /* End if () */
   else if (1 == self.count) {
      
      return [[self objectAtIndex:0] description];
      
   } /* End else if () */
   else {
      
      NSMutableString   *stResult   = [NSMutableString string];
      
      for (NSUInteger H = 0; H < self.count; ++H) {
         
         [stResult appendString:[[self objectAtIndex:H] description]];
         
         if (aDelimiter) {
            
            if (H + 1 < self.count) {
               
               [stResult appendString:aDelimiter];
               
            }  /* End if () */
            
         } /* End if () */
         
      } /* End for () */
      
      return stResult;
   }
}

#pragma mark -

- (id)safeObjectAtIndex:(NSUInteger)index {
   
   if (index >= self.count) {
      
      return nil;
      
   } /* End if () */
   
   return [self objectAtIndex:index];
}

- (id)safeSubarrayWithRange:(NSRange)aRange {
   
   if (0 == self.count) {
      
      return [NSArray array];
      
   } /* End if () */
   
   if (aRange.location >= self.count) {
      
      return [NSArray array];
      
   } /* End if () */
   
   aRange.length = MIN(aRange.length, self.count - aRange.location);
   if (0 == aRange.length) {
      
      return [NSArray array];
      
   } /* End if () */
   
   return [self subarrayWithRange:NSMakeRange(aRange.location, aRange.length)];
}

- (id)safeSubarrayFromIndex:(NSUInteger)aIndex {
   
   if (0 == self.count) {
      
      return [NSArray array];
      
   } /* End if () */
   
   if (aIndex >= self.count) {
      
      return [NSArray array];
      
   } /* End if () */
   
   return [self safeSubarrayWithRange:NSMakeRange(aIndex, self.count - aIndex)];
}

- (id)safeSubarrayWithCount:(NSUInteger)aCount {
   
   if (0 == self.count) {
      
      return [NSArray array];
      
   } /* End if () */
   
   return [self safeSubarrayWithRange:NSMakeRange(0, aCount)];
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
