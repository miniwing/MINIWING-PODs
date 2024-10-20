//
//  IDEAWKTimeUtils.m
//  IDEAWKKit
//
//  Created by Harry on 2018/7/6.
//  Copyright © 2018年 Harry. All rights reserved.
//
//  Mail : miniwing.hz@gmail.com
//


#import "IDEAWKTimeUtils.h"

@implementation IDEAWKTimeUtils

+ (NSString*)getTimeAgo:(long)aCreatedAt {
   
   // Calculate distance time string
   //
   NSString    *szTimestamp      = nil;
   time_t       tNow;
   time(&tNow);
   
   int          nDistance        = (int)difftime(tNow, aCreatedAt);
   
   if (nDistance < 0) {
      
      nDistance = 0;
   }
   
   if (nDistance < 60) {
      
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "second ago" : "seconds ago"];
   }
   else if (nDistance < 60 * 60) {
      
      nDistance = nDistance / 60;
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "minute ago" : "minutes ago"];
   }
   else if (nDistance < 60 * 60 * 24) {
      
      nDistance = nDistance / 60 / 60;
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "hour ago" : "hours ago"];
   }
   else if (nDistance < 60 * 60 * 24 * 7) {
      
      nDistance = nDistance / 60 / 60 / 24;
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "day ago" : "days ago"];
   }
   else if (nDistance < 60 * 60 * 24 * 7 * 4) {
      
      nDistance = nDistance / 60 / 60 / 24 / 7;
      szTimestamp = [NSString stringWithFormat:@"%d %s", nDistance, (nDistance == 1) ? "week ago" : "weeks ago"];
   }
   else {
      
      static __strong NSDateFormatter *g_DateFormatter = nil;
      
      if (g_DateFormatter == nil) {
         
         g_DateFormatter = [[NSDateFormatter alloc] init];
         [g_DateFormatter setLocale:[NSLocale currentLocale]];
         [g_DateFormatter setDateStyle:NSDateFormatterShortStyle];
         [g_DateFormatter setTimeStyle:NSDateFormatterShortStyle];
      }
      
      NSDate   *stDate  = [NSDate dateWithTimeIntervalSince1970:aCreatedAt];
      szTimestamp = [g_DateFormatter stringFromDate:stDate];
   }
   
   return szTimestamp;
}

@end
