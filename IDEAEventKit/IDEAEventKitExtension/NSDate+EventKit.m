//
//  NSDate+EventKit.h
//  IDEAEventKit
//
//  Created by Harry on 2021/7/21.
//  Copyright © 2021 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import <Foundation/Foundation.h>
#import <IDEAEventKit/IDEAEventKitProperty.h>

#import "NSDate+EventKit.h"

#import "IDEAEventKit/__pragma_push.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSDate (EventKit)

@def_prop_dynamic ( NSInteger ,   apple_year    );
@def_prop_dynamic ( NSInteger ,   apple_month   );
@def_prop_dynamic ( NSInteger ,   apple_day     );
@def_prop_dynamic ( NSInteger ,   apple_hour    );
@def_prop_dynamic ( NSInteger ,   apple_minute  );
@def_prop_dynamic ( NSInteger ,   apple_second  );
@def_prop_dynamic ( NSInteger ,   apple_weekday );

- (NSInteger)apple_year {
   
#ifdef __IPHONE_8_0
   return [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self].year;
#else
   return [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self].year;
#endif
}

- (NSInteger)apple_month {
   
#ifdef __IPHONE_8_0
   return [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self].month;
#else
   return [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self].month;
#endif
}

- (NSInteger)apple_day {
   
#ifdef __IPHONE_8_0
   return [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self].day;
#else
   return [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self].day;
#endif
}

- (NSInteger)apple_hour {
   
#ifdef __IPHONE_8_0
   return [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self].hour;
#else
   return [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self].hour;
#endif
}

- (NSInteger)apple_minute {
   
#ifdef __IPHONE_8_0
   return [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self].minute;
#else
   return [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self].minute;
#endif
}

- (NSInteger)apple_second {
   
#ifdef __IPHONE_8_0
   return [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self].second;
#else
   return [[NSCalendar currentCalendar] components:NSSecondCalendarUnit fromDate:self].second;
#endif
}

- (WeekdayType)apple_weekday {
   
#ifdef __IPHONE_8_0
   return (WeekdayType)[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self].weekday;
#else
   return (WeekdayType)[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self].weekday;
#endif
}

+ (NSTimeInterval)unixTime {
   
   return [[NSDate date] timeIntervalSince1970];
}

+ (NSString *)unixDate {
   
   return [[NSDate date] toString:@"yyyy/MM/dd HH:mm:ss z"];
}

+ (NSDate *)fromString:(NSString *)aString {
   
   if (nil == aString || 0 == aString.length) {
      
      return nil;
      
   } /* End if () */
   
   NSDate   *stDate = [[NSDate format:@"yyyy/MM/dd HH:mm:ss z"] dateFromString:aString];
   if (nil == stDate) {
      
      stDate = [[NSDate format:@"yyyy-MM-dd HH:mm:ss z"] dateFromString:aString];
      if (nil == stDate) {
         
         stDate = [[NSDate format:@"yyyy-MM-dd HH:mm:ss"] dateFromString:aString];
         if (nil == stDate) {
            
            stDate = [[NSDate format:@"yyyy/MM/dd HH:mm:ss"] dateFromString:aString];
            
         } /* End if () */
         
      } /* End if () */
      
   } /* End if () */
   
   return stDate;
}

+ (NSDateFormatter *)format {
   
   return [self format:@"yyyy/MM/dd HH:mm:ss z"];
}

+ (NSDateFormatter *)format:(NSString *)aFormat {
   
   return [self format:aFormat timeZoneGMT:[[NSTimeZone defaultTimeZone] secondsFromGMT]];
}

+ (NSDateFormatter *)format:(NSString *)aFormat timeZoneGMT:(NSInteger)aSeconds {
   
   static __strong NSMutableDictionary * __formatters = nil;
   
   if (nil == __formatters) {
      
      __formatters = [[NSMutableDictionary alloc] init];
      
   } /* End if () */
   
   NSString          *szKey      = [NSString stringWithFormat:@"%@ %ld", aFormat, (long)aSeconds];
   NSDateFormatter   *stFormatter= [__formatters objectForKey:szKey];
   if (nil == stFormatter) {
      
      stFormatter = [[NSDateFormatter alloc] init];
      [stFormatter setDateFormat:aFormat];
      [stFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:aSeconds]];
      [__formatters setObject:stFormatter forKey:szKey];
      
   } /* End if () */
   
   return stFormatter;
}

+ (NSDateFormatter *)format:(NSString *)aFormat timeZoneName:(NSString *)aName {
   
   static __strong NSMutableDictionary * __formatters = nil;
   
   if (nil == __formatters) {
      
      __formatters = [[NSMutableDictionary alloc] init];
      
   } /* End if () */
   
   NSString          *szKey         = [NSString stringWithFormat:@"%@ %@", aFormat, aName];
   NSDateFormatter   *stFormatter   = [__formatters objectForKey:szKey];
   
   if (nil == stFormatter) {
      
      stFormatter = [[NSDateFormatter alloc] init];
      [stFormatter setDateFormat:aFormat];
      [stFormatter setTimeZone:[NSTimeZone timeZoneWithName:aName]];
      [__formatters setObject:stFormatter forKey:szKey];
      
   } /* End if () */
   
   return stFormatter;
}

- (NSString *)toString:(NSString *)aFormat {
   
   return [self toString:aFormat timeZoneGMT:[[NSTimeZone defaultTimeZone] secondsFromGMT]];
}

- (NSString *)toString:(NSString *)aFormat timeZoneGMT:(NSInteger)aSeconds {
   
   return [[NSDate format:aFormat timeZoneGMT:aSeconds] stringFromDate:self];
}

- (NSString *)toString:(NSString *)aFormat timeZoneName:(NSString *)aName {
   
   return [[NSDate format:aFormat timeZoneName:aName] stringFromDate:self];
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __IDEA_EVENT_KIT_TESTING__

#endif // #if __IDEA_EVENT_KIT_TESTING__

#import "IDEAEventKit/__pragma_pop.h"
