//
//  IDEAFileUtils.m
//  Pods
//
//  Created by Harry on 2022/10/23.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAFileUtils.h"

@implementation IDEAFileUtils

+ (NSString *)formatFileSize:(NSInteger)size {
   
   if (size>0) {
      
      double kiloByte = size/1024.0;
      
      if (kiloByte < 1 && kiloByte > 0) {
         
         return [NSString stringWithFormat:@"%.2fByte",size];
      }
      
      double megaByte = kiloByte / 1024.0;
      
      if (megaByte < 1) {
         
         return [NSString stringWithFormat:@"%.2fK",kiloByte];
      }
      
      double gigaByte = megaByte / 1024.0;
      
      if (gigaByte < 1) {
         
         return [NSString stringWithFormat:@"%.2fM",megaByte];
      }
      
      double teraByte = gigaByte / 1024.0;
      
      if (teraByte < 1) {
         
         return [NSString stringWithFormat:@"%.2fG",gigaByte];
      }
      
      return [NSString stringWithFormat:@"%.2fT",teraByte];
   }
   
   return @"0K";
}

+ (NSString *)byteCountFormat:(NSInteger)aBytes {
   
   int                            nErr                                     = EFAULT;
   
   NSString                      *szFormat                                 = nil;
   
   NSString                      *aUnits[]                                 = {
      
      @"B", @"KB", @"MB", @"GB", @"TB", @"PB", @"EB", @"ZB", @"YB"
   };
   double                         dBytes                                   = aBytes;
   NSInteger                      nUnitIndex                               = 0;
   
   __TRY;
   
   for (nUnitIndex = 0; dBytes > 1024; ++nUnitIndex) {
      
      dBytes   = dBytes / 1024;
      
   } /* End for () */

   if (nUnitIndex <= (sizeof(aUnits) / sizeof(NSString *))) {
      
      if (0 == nUnitIndex) {
         
         szFormat = [NSString stringWithFormat:@"%ld %@", (long)dBytes, aUnits[nUnitIndex]];
         
      } /* End if () */
      else {

         szFormat = [NSString stringWithFormat:@"%.2f %@", dBytes, aUnits[nUnitIndex]];

      } /* End else */
      
   } /* End if () */

   __CATCH(nErr);
   
   return szFormat;
}

@end
