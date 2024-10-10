//
//  IDEATimeUtils.m
//  IDEAKit
//
//  Created by Harry on 2018/7/6.
//  Copyright © 2018年 Harry. All rights reserved.
//
//  Mail : miniwing.hz@gmail.com
//


#import "IDEATimeUtils.h"

@implementation IDEATimeUtils

+ (NSString *)getTimeAgo:(long)aCreatedAt {
   
   // Calculate distance time string
   //
   NSString    *szTimestamp      = nil;
   time_t       tNow;
   time(&tNow);
   
   int          nDistance        = (int)difftime(tNow, aCreatedAt);
   
   if (nDistance < 0) {
      
      nDistance = 0;
      
   } /* End if () */
   
   if (nDistance < 60) {
      
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "second ago" : "seconds ago"];
      
   } /* End if () */
   else if (nDistance < 60 * 60) {
      
      nDistance = nDistance / 60;
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "minute ago" : "minutes ago"];
      
   } /* End else if () */
   else if (nDistance < 60 * 60 * 24) {
      
      nDistance = nDistance / 60 / 60;
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "hour ago" : "hours ago"];
      
   } /* End else if () */
   else if (nDistance < 60 * 60 * 24 * 7) {
      
      nDistance = nDistance / 60 / 60 / 24;
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "day ago" : "days ago"];
      
   } /* End else if () */
   else if (nDistance < 60 * 60 * 24 * 7 * 4) {
      
      nDistance = nDistance / 60 / 60 / 24 / 7;
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "week ago" : "weeks ago"];
      
   } /* End else if () */
   else {
      
      static __strong NSDateFormatter *g_DateFormatter = nil;
      
      if (g_DateFormatter == nil) {
         
         g_DateFormatter = [[NSDateFormatter alloc] init];
         [g_DateFormatter setLocale:[NSLocale currentLocale]];
         [g_DateFormatter setDateStyle:NSDateFormatterShortStyle];
         [g_DateFormatter setTimeStyle:NSDateFormatterShortStyle];
         
      } /* End if () */
      
      NSDate   *stDate  = [NSDate dateWithTimeIntervalSince1970:aCreatedAt];
      szTimestamp = [g_DateFormatter stringFromDate:stDate];
      
   } /* End else */
   
   return szTimestamp;
}

+ (NSString *)millisecondToHMS:(NSTimeInterval)aMillisecond {
   
   NSString    *szTimestamp      = nil;

   NSInteger    nTime            = 0;
   
   NSInteger    nSecond          = 0;
   NSInteger    nMinute          = 0;
   NSInteger    nHour            = 0;
   
   /**
    * 毫秒换算成秒
    */
   nTime    = aMillisecond / 1000;
   
   nSecond  = nTime % 60;
   nMinute  = (nTime - nSecond) / 60 % 60;
   nHour    = ((nTime - nSecond) / 60 - nMinute) / 60;

   szTimestamp = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", nHour, nMinute, nSecond];
   
   return szTimestamp;
}

@end
