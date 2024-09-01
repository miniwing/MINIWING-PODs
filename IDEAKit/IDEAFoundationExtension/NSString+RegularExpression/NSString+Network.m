//
//  NSString+RegularExpression.m
//  IDEAKit
//
//  Created by Harry on 2021/7/28.
//  Copyright © 2024 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//

#import "NSString+Network.h"

@implementation NSString (Network)

- (NSArray<NSString *> *)IPV4s {
   
   NSString                      *stPattern  = @"((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})(\\.((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})){3}";
   NSError                       *stError    = NULL;
   NSRegularExpression           *stRegex    = [NSRegularExpression regularExpressionWithPattern:stPattern
                                                                                         options:0
                                                                                           error:&stError];
   NSArray<NSTextCheckingResult *>*stMatch   = [stRegex matchesInString:self
                                                                options:NSMatchingReportCompletion
                                                                  range:NSMakeRange(0, [self length])];
   
   NSMutableArray<NSString *>    *stIPV4s    = [NSMutableArray<NSString *> array];
   
   for (NSTextCheckingResult *stResult in stMatch) {
      
      LogDebug((@"-[NSString IPV4s] : ResultType : %ld", stResult.resultType));
      
      NSString *szIPV4  = [self substringWithRange:stResult.range];
      LogDebug((@"-[NSString IPV4s] : IPV4 : %@", szIPV4));
      
      if (NO == kStringIsEmpty(szIPV4)) {
         
         [stIPV4s addObject:szIPV4];
         
      } /* End if () */
      
   } /* End for () */
   
   return stIPV4s;
}

- (NSArray<NSString *> *)DOMAINs {
   
   NSString                      *stPattern  = @"((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})(\\.((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})){3}";
   NSError                       *stError    = NULL;
   NSRegularExpression           *stRegex    = [NSRegularExpression regularExpressionWithPattern:stPattern
                                                                                         options:0
                                                                                           error:&stError];
   NSArray<NSTextCheckingResult *>*stMatch   = [stRegex matchesInString:self
                                                                options:NSMatchingReportCompletion
                                                                  range:NSMakeRange(0, [self length])];
   
   NSMutableArray<NSString *>    *stDOMAINs  = [NSMutableArray<NSString *> array];
   
   for (NSTextCheckingResult *stResult in stMatch) {
      
      LogDebug((@"-[NSString DOMAINs] : ResultType : %ld", stResult.resultType));
      
      NSString *szDOMAIN  = [self substringWithRange:stResult.range];
      LogDebug((@"-[NSString DOMAINs] : DOMAIN : %@", szDOMAIN));
      
      if (NO == kStringIsEmpty(szDOMAIN)) {
         
         [stDOMAINs addObject:szDOMAIN];
         
      } /* End if () */
      
   } /* End for () */
   
   return stDOMAINs;
}
@end
