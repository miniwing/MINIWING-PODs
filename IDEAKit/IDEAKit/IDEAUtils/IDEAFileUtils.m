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

@end
