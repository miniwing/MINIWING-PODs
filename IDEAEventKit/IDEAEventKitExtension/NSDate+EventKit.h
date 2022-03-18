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

#pragma mark -

#define SECOND       (1)
#define MINUTE       (60 * SECOND)
#define HOUR         (60 * MINUTE)
#define DAY          (24 * HOUR)
#define MONTH        (30 * DAY)
#define YEAR         (12 * MONTH)
#define NOW          [NSDate date]

#pragma mark -

typedef enum
{
   WeekdayType_Sunday      = 1,
   WeekdayType_Monday,
   WeekdayType_Tuesday,
   WeekdayType_Wednesday,
   WeekdayType_Thursday,
   WeekdayType_Friday,
   WeekdayType_Saturday
} WeekdayType;

#pragma mark -

@interface NSDate (EventKit)

@prop_readonly( NSInteger,    apple_year    );
@prop_readonly( NSInteger,    apple_month   );
@prop_readonly( NSInteger,    apple_day     );
@prop_readonly( NSInteger,    apple_hour    );
@prop_readonly( NSInteger,    apple_minute  );
@prop_readonly( NSInteger,    apple_second  );
@prop_readonly( WeekdayType,  apple_weekday );

+ (NSTimeInterval)unixTime;
+ (NSString *)unixDate;

+ (NSDate *)fromString:(NSString *)aString;

+ (NSDateFormatter *)format;
+ (NSDateFormatter *)format:(NSString *)aFormat;
+ (NSDateFormatter *)format:(NSString *)aFormat timeZoneGMT:(NSInteger)aHours;
+ (NSDateFormatter *)format:(NSString *)aFormat timeZoneName:(NSString *)aName;

- (NSString *)toString:(NSString *)aFormat;
- (NSString *)toString:(NSString *)aFormat timeZoneGMT:(NSInteger)aHours;
- (NSString *)toString:(NSString *)aFormat timeZoneName:(NSString *)aName;

@end
