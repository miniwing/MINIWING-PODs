//
//  NSArray+Extension.m
//  IDEAWKKit
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray(IExtension)

- (NSInteger)firstIndexOf:(id)aObject {
   
   NSInteger       nIndex           = NSNotFound;
   
   for (int H = 0; H < self.count; ++H) {
      
      if (([self objectAtIndex:H] == aObject) || ([[self objectAtIndex:H] isEqual:aObject])) {
         
         nIndex   = H;
         
         break;
         
      } /* End if () */
      
   } /* End for () */
   
   return nIndex;
}

@end

