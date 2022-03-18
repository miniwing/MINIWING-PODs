//
//  NSObject+EventKit.h
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

#undef  BASE_CLASS
#define BASE_CLASS( __class ) \
        + (Class)baseClass \
        { \
           return NSClassFromString( @(#__class) ); \
        }

#undef  CONVERT_CLASS
#define CONVERT_CLASS( __name, __class ) \
        + (Class)convertClass_##__name \
        { \
           return NSClassFromString( @(#__class) ); \
        }

#pragma mark -

@interface NSObject (EventKit)

+ (Class)baseClass;

+ (id)unserializeForUnknownValue:(id)aValue;
+ (id)serializeForUnknownValue:(id)aValue;

- (void)deepEqualsTo:(id)aObject;
- (void)deepCopyFrom:(id)aObject;

+ (id)unserialize:(id)aObject;
+ (id)unserialize:(id)aObject withClass:(Class)aClass;

- (id)JSONEncoded;
- (id)JSONDecoded;

- (BOOL)toBool;
- (float)toFloat;
- (double)toDouble;
- (NSInteger)toInteger;
- (NSUInteger)toUnsignedInteger;

- (NSURL *)toURL;
- (NSDate *)toDate;
- (NSData *)toData;
- (NSNumber *)toNumber;
- (NSString *)toString;

- (id)clone;                     // override point
- (id)serialize;                 // override point
- (void)unserialize:(id)aObject; // override point
- (void)zerolize;                // override point

@end
