//
//  YYWebImageManager+Operation.m
//  IDEAKit
//
//  Created by Harry on 2019/3/20.
//  Copyright © 2019年 Harry. All rights reserved.
//

#import "YYWebImageManager+Operation.h"

#if YY_WebImageManager_Operation

@implementation YYWebImageManager (Operation)

- (BOOL)containOperation:(NSString *)aURL {
   
   BOOL         bContain         = NO;
   
   NSArray     *stOperations     = self.queue.operations;
   
   for (YYWebImageOperation *stOperation in stOperations) {
      
      if ([stOperation.cacheKey isEqualToString:aURL]) {
         
         bContain = YES;
         
         break;
         
      } /* End if () */
      
   } /* End for () */
   
   return bContain;
}

@end

#endif /* YY_WebImageManager_Operation */
