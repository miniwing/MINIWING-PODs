//
//  NSBundle+XIB.m
//  iLib
//
//  Created by Harry Cai on 14-2-7.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import "NSBundle+XIB.h"


#if __UNIVERSAL__
#  define __UNIVERSAL_IPHONE__      __ON__
#  define __UNIVERSAL_IPAD__        __ON__
#else
#  define __UNIVERSAL_IPHONE__      __OFF__
#  define __UNIVERSAL_IPAD__        __OFF__
#endif /* __UNIVERSAL__ */


@implementation NSBundle (XIB)

+ (NSString *)XIB:(NSString *)aXIBCLass PAD:(BOOL)aPAD
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
#endif /* __UNIVERSAL__ */
      
#if __UNIVERSAL_IPHONE__
   {
      szDevice = @"_iPhone";
   }
#endif /* __UNIVERSAL_IPHONE__ */
   
   LogDebug((@"XIB : %@", [NSString stringWithFormat:@"%@%@", aXIBCLass, szDevice]));
   
   return [NSString stringWithFormat:@"%@%@", aXIBCLass, szDevice];
}

@end

