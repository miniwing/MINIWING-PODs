//
//  NSLocale+Localization.m
//  IDEAWKKit
//
//  Created by Harry on 2022/10/27.
//

#import "NSLocale+Localization.h"

@implementation NSLocale (Localization)

+ (NSString *)currentLocalization {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szLocalization                           = nil;
   
   NSLocale                      *stLocale                                 = [NSLocale currentLocale];
   NSString                      *szCountryCode                            = nil;
   
   __TRY;
      
   if (!kStringIsBlank(stLocale.collatorIdentifier) && !kStringIsBlank(stLocale.countryCode)) {
      
      szCountryCode  = [NSString stringWithFormat:@"-%@", stLocale.countryCode];
      szLocalization = [stLocale.collatorIdentifier replaceAll:szCountryCode with:@""];
      
   } /* End if () */
   
   __CATCH(nErr);

   return szLocalization;
}

@end
